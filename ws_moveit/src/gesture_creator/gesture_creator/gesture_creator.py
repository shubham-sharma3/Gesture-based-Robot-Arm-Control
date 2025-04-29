# gesture_detector.py
import rclpy
from rclpy.node import Node
from std_msgs.msg import String
import mediapipe as mp
import cv2

class GestureDetector(Node):
    def __init__(self):
        super().__init__('gesture_detector')
        self.publisher_ = self.create_publisher(String, 'hand_gesture', 10)

        self.gesture_labels = ['Thumb_Up, Pointing_Up, Closed_Fist']
        self.VisionRunningMode = mp.tasks.vision.RunningMode
        self.base_options = mp.tasks.python.BaseOptions(model_asset_path='gesture_recognizer.task')
        self.options = mp.tasks.python.vision.GestureRecognizerOptions(base_options=self.base_options, running_mode=self.VisionRunningMode.VIDEO )
        self.recognizer = mp.tasks.python.vision.GestureRecognizer.create_from_options(self.options)

        self.mp_hands = mp.solutions.hands
        self.mp_drawing = mp.solutions.drawing_utils
        self.hands = self.mp_hands.Hands(
            max_num_hands=1,
            min_detection_confidence=0.7,
            min_tracking_confidence=0.5
        )
        # Initialize webcam
        self.cap = cv2.VideoCapture(0)
        if not self.cap.isOpened():
            self.get_logger().error("Failed to open webcam")
            return
        # Create timer to process frames
        self.timer = self.create_timer(0.1, self.process_frame)
        self.get_logger().info("Gesture node started")

    def detect(self):

        gesture = "none"
        success, img = self.cap.read()
        img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        if  success:
            recognition_result = self.recognizer.recognize_for_video( mp.Image(data=img_rgb))
        top_gesture = recognition_result.gestures[0][0]

        if top_gesture in self.gesture_labels:
            gesture = top_gesture

        results = self.hands.process(img_rgb)

         # Draw the hand annotations on the image.
        image.flags.writeable = True
        image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)

        if results.multi_hand_landmarks:
            for hand_landmarks in results.multi_hand_landmarks:
                self.mp_drawing.draw_landmarks(
                    image,
                    hand_landmarks,
                    self.mp_hands.HAND_CONNECTIONS,
                    self.mp_drawing_styles.get_default_hand_landmarks_style(),
                    self.mp_drawing_styles.get_default_hand_connections_style())
            
        

        msg = String()
        msg.data = gesture
        self.publisher_.publish(msg)

        cv2.imshow('Hands Detection', cv2.flip(image, 1))
        cv2.waitKey(1)

def main(args=None):
    rclpy.init(args=args)          # 1. Initialize ROS 2
    node = GestureDetector()            # 2. Create your custom node
    try:
        rclpy.spin(node)            # 3. Keep node running
    except KeyboardInterrupt:       # 4. Handle Ctrl+C
        pass
    finally:
        node.destroy_node()         # 5. Cleanup node
        rclpy.shutdown()            # 6. Shutdown ROS 2

if __name__ == '__main__':
    main()
