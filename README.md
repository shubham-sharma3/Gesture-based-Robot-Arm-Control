# Gesture-based-Robot-Arm-Control

A ROS2 Python node that uses MediaPipe to detect and classify hand gestures (Stop, Point, Thumbs Up) from webcam input, publishing gesture commands as strings to control a robot arm. Leveraging hand landmark detection, the system enables intuitive human-robot interaction for robotic applications.

Key Features:
- Real-time hand gesture recognition using MediaPipe's Hands solution
- Publishes gesture commands via ROS2 for robot arm control
- Supports Stop, Point, and Thumbs Up gestures with rule-based classification
- Visual feedback with annotated video feed

Technologies: ROS2, MediaPipe, OpenCV, Python
