#include <memory>
#include <rclcpp/rclcpp.hpp>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <tf2/LinearMath/Quaternion.h>
#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>
#include <std_msgs/msg/string.hpp>
using std::placeholders::_1;

class MoveToPose : public rclcpp::Node
{
  public:
    MoveToPose() : Node("move_to_pose")
    {
        gesture_sub_ = this->create_subscription<std_msgs::msg::String>(
            "gesture",
            10,
            std::bind(&MoveToPose::gesture_callback, this, _1)
        );

        move_group_ = std::make_shared<moveit::planning_interface::MoveGroupInterface>(shared_from_this(), "panda_arm");
        RCLCPP_INFO(this->get_logger(), "Robot Arm Initialized");
    }
    
    private:
    void gesture_callback(const std_msgs::msg::String::SharedPtr msg)
    {
        RCLCPP_INFO(this->get_logger(), "Gesture received: %s", msg->data.c_str());
        tf2::Quaternion quat_goal;
        geometry_msgs::msg::Pose pose_goal;

        if (msg->data == "open_hand")
        {
            quat_goal.setRPY(0, 0, -M_PI/4);
            geometry_msgs::msg::Quaternion quat_goal_msg = tf2::toMsg(quat_goal);

            // Set the pose goal
            pose_goal.position.x = 0.4;
            pose_goal.position.y = 0.0;
            pose_goal.position.z = 0.4;
            pose_goal.orientation = quat_goal_msg;
        }

        else if (msg->data == "fist")
        {
            quat_goal.setRPY(0, 0, M_PI/4);
            geometry_msgs::msg::Quaternion quat_goal_msg = tf2::toMsg(quat_goal);

            // Set the pose goal
            pose_goal.position.x = -0.4;
            pose_goal.position.y = 0.3;
            pose_goal.position.z = -0.4;
            pose_goal.orientation = quat_goal_msg;
        }

        else if (msg->data == "thumb_up")
        {
            quat_goal.setRPY(0, 0, M_PI/2);
            geometry_msgs::msg::Quaternion quat_goal_msg = tf2::toMsg(quat_goal);

            // Set the pose goal
            pose_goal.position.x = 0.4;
            pose_goal.position.y = 1.0;
            pose_goal.position.z = 0.4;
            pose_goal.orientation = quat_goal_msg;
        }

        else 
        {
            RCLCPP_INFO(this->get_logger(), "Invalid gesture");
        }

        move_group_->setPoseTarget(pose_goal);
        moveit::planning_interface::MoveGroupInterface::Plan my_plan;
        auto const outcome = static_cast<bool>(move_group_->plan(my_plan));

        if (outcome)
        {
            move_group_->move();
        }
        else
        {
            RCLCPP_ERROR(this->get_logger(), "Planning failed");
        }
    }

    rclcpp::Subscription<std_msgs::msg::String>::SharedPtr gesture_sub_;
    std::shared_ptr<moveit::planning_interface::MoveGroupInterface> move_group_;
};

int main(int argc, char *argv[])
{
    rclcpp::init(argc, argv);
    auto node = std::make_shared<MoveToPose>();
    rclcpp::spin(node);
    rclcpp::shutdown();
    return 0;
}
    
    
    