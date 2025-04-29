#include <memory>
#include <rclcpp/rclcpp.hpp>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <tf2/LinearMath/Quaternion.h>
#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>

int main(int argc, char* argv[])
{
    rclcpp::init(argc, argv);
    auto const node = std::make_shared<rclcpp::Node>
    (
    "move_arm",
    rclcpp::NodeOptions().automatically_declare_parameters_from_overrides(true)
    );
    
    RCLCPP_INFO(rclcpp::get_logger("move_arm"), "Starting MoveArm node...");
    
    moveit::planning_interface::MoveGroupInterface MoveGroupInterface(node, "panda_arm");
    
    tf2::Quaternion quat_goal;

    quat_goal.setRPY(0, 0, -M_PI/4);
    geometry_msgs::msg::Quaternion quat_goal_msg = tf2::toMsg(quat_goal);

    geometry_msgs::msg::Pose pose_goal;
    pose_goal.position.x = 0.4;
    pose_goal.position.y = 0.0;
    pose_goal.position.z = 0.4;
    pose_goal.orientation = quat_goal_msg;

    MoveGroupInterface.setPoseTarget(pose_goal);
    moveit::planning_interface::MoveGroupInterface::Plan my_plan;
    auto const outcome = static_cast<bool>(MoveGroupInterface.plan(my_plan));

    if (outcome)
    {
        MoveGroupInterface.move();
    }
    else
    {
      RCLCPP_ERROR(rclcpp::get_logger("move_arm"), "Planning failed");
    }
    


  rclcpp::shutdown();
  return 0;
}