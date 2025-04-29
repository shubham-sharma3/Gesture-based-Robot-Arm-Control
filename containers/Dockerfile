# Use a lighter ROS 2 Humble base image with arm64 support
FROM ghcr.io/sloretz/ros:humble-desktop

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=humble

# Define build arguments
ARG USERNAME=rosuser
ARG USER_UID=1000
ARG USER_GID=1000

# Install sudo and other essentials
RUN apt-get update && apt-get install -y \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create user with specified UID and GID
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    && echo "${USERNAME}:${USERNAME}" | chpasswd \
    && usermod --shell /bin/bash ${USERNAME} \
    && usermod -aG sudo ${USERNAME} \
    && mkdir -p /etc/sudoers.d \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

# Set ownership of the home directory
RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-colcon-common-extensions \
    python3-rosdep \
    wget \
    git \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep
RUN rm -f /etc/ros/rosdep/sources.list.d/20-default.list && \
    rosdep init && \
    rosdep update

#Install Ros Control
RUN apt-get update && apt-get install -y \
    ros-humble-ros2-control \
    ros-humble-ros2-controllers \
    && rm -rf /var/lib/apt/lists/*

# Install Gazebo for ROS 2 (arm64-compatible)
#RUN apt-get update && apt-get install -y \
#    ros-humble-gazebo-ros-pkgs \
#    && rm -rf /var/lib/apt/lists/*

# Install OpenCV
RUN apt-get update && apt-get install -y \
    libopencv-dev \
    python3-opencv \
    && rm -rf /var/lib/apt/lists/*

# Install MoveIt 2
RUN apt-get update && apt-get install -y \
    ros-humble-moveit
# Install RQT and common plugins
RUN apt-get update && apt-get install -y \
    ros-humble-rqt \
    ros-humble-rqt-common-plugins \
    && rm -rf /var/lib/apt/lists/*

# Install MediaPipe
RUN pip3 install mediapipe

# Install PlotJuggler
RUN apt-get update && apt-get install -y \
    ros-humble-plotjuggler-ros \
    && rm -rf /var/lib/apt/lists/*

RUN sudo apt install python3-rosdep -y \
    && sudo apt install python3-colcon-common-extensions -y \
    && sudo apt install wget -y \
    && sudo apt install git -y \
    && sudo apt install build-essential -y \
    && sudo apt install cmake -y \
    && sudo apt install python3-vcstool -y


RUN rosdep update 



# Source ROS 2 setup
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /home/${USERNAME}/.bashrc

# Switch to the non-root user
USER ${USERNAME}

# Set working directory
WORKDIR /home/${USERNAME}

# Set entrypoint
CMD ["bash"]