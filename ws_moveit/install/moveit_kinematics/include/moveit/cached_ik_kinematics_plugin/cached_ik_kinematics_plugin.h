/*********************************************************************
 * Software License Agreement (BSD License)
 *
 *  Copyright (c) 2017, Rice University
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above
 *     copyright notice, this list of conditions and the following
 *     disclaimer in the documentation and/or other materials provided
 *     with the distribution.
 *   * Neither the name of the Rice University nor the names of its
 *     contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 *  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 *  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 *  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 *  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 *  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 *  POSSIBILITY OF SUCH DAMAGE.
 *********************************************************************/

/* Author: Mark Moll */

#pragma once

#include <moveit/cached_ik_kinematics_plugin/detail/NearestNeighborsGNAT.h>
#include <moveit/kdl_kinematics_plugin/kdl_kinematics_plugin.h>
#include <moveit/kinematics_base/kinematics_base.h>
#include <moveit/robot_model/robot_model.h>
// TODO: Remove conditional includes when released to all active distros.
#if __has_include(<tf2/LinearMath/Quaternion.hpp>)
#include <tf2/LinearMath/Quaternion.hpp>
#else
#include <tf2/LinearMath/Quaternion.h>
#endif
#if __has_include(<tf2/LinearMath/Vector3.hpp>)
#include <tf2/LinearMath/Vector3.hpp>
#else
#include <tf2/LinearMath/Vector3.h>
#endif
#include <mutex>
#include <unordered_map>
#include <utility>
#include <filesystem>

namespace cached_ik_kinematics_plugin
{
static const rclcpp::Logger LOGGER =
    rclcpp::get_logger("moveit_cached_ik_kinematics_plugin.cached_ik_kinematics_plugin");

/** \brief A cache of inverse kinematic solutions */
class IKCache
{
public:
  struct Options
  {
    Options() : max_cache_size(5000), min_pose_distance(1.0), min_joint_config_distance(1.0), cached_ik_path("")
    {
    }
    unsigned int max_cache_size;
    double min_pose_distance;
    double min_joint_config_distance;
    std::string cached_ik_path;
  };

  /**
    \brief class to represent end effector pose

     tf2::Transform stores orientation as a matrix, so we define our
     own pose class that maps more directly to geometry_msgs::msg::Pose and
     for which we can more easily define a distance metric.
  */
  struct Pose
  {
    Pose() = default;
    Pose(const geometry_msgs::msg::Pose& pose);
    tf2::Vector3 position;
    tf2::Quaternion orientation;
    /** compute the distance between this pose and another pose */
    double distance(const Pose& pose) const;
  };

  /**
    the IK cache entries are simply a pair formed by a vector of poses
    (one for each end effector) and a configuration that achieves those
    poses
  */
  using IKEntry = std::pair<std::vector<Pose>, std::vector<double>>;

  IKCache();
  ~IKCache();
  IKCache(const IKCache&) = delete;

  /** get the entry from the IK cache that best matches a given pose */
  const IKEntry& getBestApproximateIKSolution(const Pose& pose) const;
  /** get the entry from the IK cache that best matches a given vector of poses */
  const IKEntry& getBestApproximateIKSolution(const std::vector<Pose>& poses) const;
  /** initialize cache, read from disk if found */
  void initializeCache(const std::string& robot_id, const std::string& group_name, const std::string& cache_name,
                       const unsigned int num_joints, const Options& opts = Options());
  /**
    insert (pose,config) as an entry if it's different enough from the
    most similar cache entry
  */
  void updateCache(const IKEntry& nearest, const Pose& pose, const std::vector<double>& config) const;
  /**
    insert (pose,config) as an entry if it's different enough from the
    most similar cache entry
  */
  void updateCache(const IKEntry& nearest, const std::vector<Pose>& poses, const std::vector<double>& config) const;
  /** verify with forward kinematics that the cache entries are correct */
  void verifyCache(kdl_kinematics_plugin::KDLKinematicsPlugin& fk) const;

protected:
  /** compute the distance between two joint configurations */
  double configDistance2(const std::vector<double>& config1, const std::vector<double>& config2) const;
  /** save current state of cache to disk */
  void saveCache() const;

  /** number of joints in the system */
  unsigned int num_joints_;

  /** for all cache entries, the poses are at least minPoseDistance_ apart ... */
  double min_pose_distance_;
  /** ... or the configurations are at least minConfigDistance2_^.5 apart. */
  double min_config_distance2_;
  /** maximum size of the cache */
  unsigned int max_cache_size_;
  /** file name for loading / saving cache */
  std::filesystem::path cache_file_name_;

  /**
    the IK methods are declared const in the base class, but the
    wrapped methods need to modify the cache, so the next four members
    are mutable
    cache of IK solutions
  */
  mutable std::vector<IKEntry> ik_cache_;
  /** nearest neighbor data structure over IK cache entries */
  mutable NearestNeighborsGNAT<IKEntry*> ik_nn_;
  /** size of the cache when it was last saved */
  mutable unsigned int last_saved_cache_size_{ 0 };
  /** mutex for changing IK cache */
  mutable std::mutex lock_;
};

/** a container of IK caches for cases where there is no fixed base frame */
class IKCacheMap : public std::unordered_map<std::string, IKCache*>
{
public:
  using IKEntry = IKCache::IKEntry;
  using Pose = IKCache::Pose;

  IKCacheMap(const std::string& robot_description, const std::string& group_name, unsigned int num_joints);
  ~IKCacheMap();
  /**
    get the entry from the IK cache that best matches a given vector of
    poses, with a specified set of fixed and active tip links
  */
  const IKEntry& getBestApproximateIKSolution(const std::vector<std::string>& fixed,
                                              const std::vector<std::string>& active,
                                              const std::vector<Pose>& poses) const;
  /**
    insert (pose,config) as an entry if it's different enough from the
    most similar cache entry
  */
  void updateCache(const IKEntry& nearest, const std::vector<std::string>& fixed,
                   const std::vector<std::string>& active, const std::vector<Pose>& poses,
                   const std::vector<double>& config);

protected:
  std::string getKey(const std::vector<std::string>& fixed, const std::vector<std::string>& active) const;
  std::string robot_description_;
  std::string group_name_;
  unsigned int num_joints_;
};

// Helper class to enable/disable initialize() methods with new/old API
// HasRobotModelApi<T>::value provides a true/false constexpr depending on KinematicsPlugin offers the new Api
// This uses SFINAE magic: https://jguegant.github.io/blogs/tech/sfinae-introduction.html
template <typename KinematicsPlugin, typename = bool>
struct HasRobotModelApi : std::false_type
{
};

template <typename KinematicsPlugin>
struct HasRobotModelApi<KinematicsPlugin, decltype(std::declval<KinematicsPlugin&>().initialize(
                                              std::declval<const rclcpp::Node::SharedPtr&>(),
                                              std::declval<const moveit::core::RobotModel&>(), std::string(),
                                              std::string(), std::vector<std::string>(), 0.0))> : std::true_type
{
};

template <typename KinematicsPlugin, typename = bool>
struct HasRobotDescApi : std::false_type
{
};

template <typename KinematicsPlugin>
struct HasRobotDescApi<KinematicsPlugin,
                       decltype(std::declval<KinematicsPlugin&>().KinematicsPlugin::initialize(
                           std::string(), std::string(), std::string(), std::vector<std::string>(), 0.0))>
  : std::true_type
{
};

/** Caching wrapper for kinematics::KinematicsBase-derived IK solvers. */
template <class KinematicsPlugin>
class CachedIKKinematicsPlugin : public KinematicsPlugin
{
public:
  using Pose = IKCache::Pose;
  using IKEntry = IKCache::IKEntry;
  using IKCallbackFn = kinematics::KinematicsBase::IKCallbackFn;
  using KinematicsQueryOptions = kinematics::KinematicsQueryOptions;

  CachedIKKinematicsPlugin();

  ~CachedIKKinematicsPlugin() override;

  // virtual methods that need to be wrapped:

  bool initialize(const rclcpp::Node::SharedPtr& node, const moveit::core::RobotModel& robot_model,
                  const std::string& group_name, const std::string& base_frame,
                  const std::vector<std::string>& tip_frames, double search_discretization) override
  {
    node_ = node;
    return initializeImpl(node, robot_model, group_name, base_frame, tip_frames, search_discretization);
  }

  bool getPositionIK(const geometry_msgs::msg::Pose& ik_pose, const std::vector<double>& ik_seed_state,
                     std::vector<double>& solution, moveit_msgs::msg::MoveItErrorCodes& error_code,
                     const KinematicsQueryOptions& options = KinematicsQueryOptions()) const override;

  bool searchPositionIK(const geometry_msgs::msg::Pose& ik_pose, const std::vector<double>& ik_seed_state,
                        double timeout, std::vector<double>& solution, moveit_msgs::msg::MoveItErrorCodes& error_code,
                        const KinematicsQueryOptions& options = KinematicsQueryOptions()) const override;

  bool searchPositionIK(const geometry_msgs::msg::Pose& ik_pose, const std::vector<double>& ik_seed_state,
                        double timeout, const std::vector<double>& consistency_limits, std::vector<double>& solution,
                        moveit_msgs::msg::MoveItErrorCodes& error_code,
                        const KinematicsQueryOptions& options = KinematicsQueryOptions()) const override;

  bool searchPositionIK(const geometry_msgs::msg::Pose& ik_pose, const std::vector<double>& ik_seed_state,
                        double timeout, std::vector<double>& solution, const IKCallbackFn& solution_callback,
                        moveit_msgs::msg::MoveItErrorCodes& error_code,
                        const KinematicsQueryOptions& options = KinematicsQueryOptions()) const override;

  bool searchPositionIK(const geometry_msgs::msg::Pose& ik_pose, const std::vector<double>& ik_seed_state,
                        double timeout, const std::vector<double>& consistency_limits, std::vector<double>& solution,
                        const IKCallbackFn& solution_callback, moveit_msgs::msg::MoveItErrorCodes& error_code,
                        const KinematicsQueryOptions& options = KinematicsQueryOptions()) const override;

private:
  rclcpp::Node::SharedPtr node_;

  IKCache cache_;

  void initCache(const std::string& robot_id, const std::string& group_name, const std::string& cache_name);

  /* Using templates and SFINAE magic, we can selectively enable/disable methods depending on
     availability of API in wrapped KinematicsPlugin class.
     However, as templates and virtual functions cannot be combined, we need helpers initializeImpl(). */
  template <class T = KinematicsPlugin>
  typename std::enable_if<HasRobotModelApi<T>::value, bool>::type
  initializeImpl(const rclcpp::Node::SharedPtr& node, const moveit::core::RobotModel& robot_model,
                 const std::string& group_name, const std::string& base_frame,
                 const std::vector<std::string>& tip_frames, double search_discretization)
  {
    if (tip_frames.size() != 1)
    {
      RCLCPP_ERROR(LOGGER, "This solver does not support multiple tip frames");
      return false;
    }

    // call initialize method of wrapped class
    if (!KinematicsPlugin::initialize(node, robot_model, group_name, base_frame, tip_frames, search_discretization))
      return false;
    initCache(robot_model.getName(), group_name, base_frame + tip_frames[0]);
    return true;
  }

  template <class T = KinematicsPlugin>
  typename std::enable_if<!HasRobotModelApi<T>::value, bool>::type
  initializeImpl(const rclcpp::Node::SharedPtr& /*unused*/, const moveit::core::RobotModel& /*unused*/,
                 const std::string& /*unused*/, const std::string& /*unused*/,
                 const std::vector<std::string>& /*unused*/, double /*unused*/)
  {
    return false;  // API not supported
  }

  template <class T = KinematicsPlugin>
  typename std::enable_if<HasRobotDescApi<T>::value, bool>::type
  initializeImpl(const std::string& robot_description, const std::string& group_name, const std::string& base_frame,
                 const std::string& tip_frame, double search_discretization)
  {
    // call initialize method of wrapped class
    if (!KinematicsPlugin::initialize(robot_description, group_name, base_frame, tip_frame, search_discretization))
      return false;
    initCache(robot_description, group_name, base_frame + tip_frame);
    return true;
  }

  template <class T = KinematicsPlugin>
  typename std::enable_if<!HasRobotDescApi<T>::value, bool>::type
  initializeImpl(const std::string& /*unused*/, const std::string& /*unused*/, const std::string& /*unused*/,
                 const std::string& /*unused*/, double /*unused*/)
  {
    return false;  // API not supported
  }
};

/**
  Caching wrapper for IK solvers that implement the multi-tip API.

  Most solvers don't implement this, so the CachedIKKinematicsPlugin
  base class simply doesn't wrap the relevant methods and the
  implementation in the abstract base class will be called. Ideally,
  the two cache wrapper classes would be combined, but it's tricky to
  call a method in kinematics::KinematicsBase or KinematicsPlugin
  depending on whether KinematicsPlugin has overridden that method or
  not (although it can be done with some template meta-programming).
*/
template <class KinematicsPlugin>
class CachedMultiTipIKKinematicsPlugin : public CachedIKKinematicsPlugin<KinematicsPlugin>
{
public:
  using Pose = IKCache::Pose;
  using IKEntry = IKCache::IKEntry;
  using IKCallbackFn = kinematics::KinematicsBase::IKCallbackFn;
  using KinematicsQueryOptions = kinematics::KinematicsQueryOptions;

  bool initialize(const rclcpp::Node::SharedPtr& node, const moveit::core::RobotModel& robot_model,
                  const std::string& group_name, const std::string& base_frame,
                  const std::vector<std::string>& tip_frames, double search_discretization) override;

  bool searchPositionIK(const std::vector<geometry_msgs::msg::Pose>& ik_poses, const std::vector<double>& ik_seed_state,
                        double timeout, const std::vector<double>& consistency_limits, std::vector<double>& solution,
                        const IKCallbackFn& solution_callback, moveit_msgs::msg::MoveItErrorCodes& error_code,
                        const KinematicsQueryOptions& options = KinematicsQueryOptions(),
                        const moveit::core::RobotState* context_state = nullptr) const override;
};
}  // namespace cached_ik_kinematics_plugin

#include "cached_ik_kinematics_plugin-inl.h"
