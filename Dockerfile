# Generated Dockerfile for Project Configuration
# Project: Project Configuration
# Type: custom
# Generated: 2025-08-17T17:10:06.322Z

FROM ros:humble-ros-base-jammy

# Configure RMW implementation
ENV RMW_IMPLEMENTATION=cyclonedds

# Set working directory

# Install Gazebo simulation packages
RUN apt-get update && apt-get install -y \
    gazebo \
    libgazebo-dev \
    ros-${ROS_DISTRO}-gazebo-ros-pkgs \
    ros-${ROS_DISTRO}-gazebo-ros-control \
    && rm -rf /var/lib/apt/lists/*

# Install keyboard teleop
RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-teleop-twist-keyboard \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    curl \
    python3-pip \
    python3-dev \
    gazebo \
    libgazebo-dev \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV ROS_DISTRO=humble
ENV RMW_IMPLEMENTATION=cyclonedds

# Expose ports
EXPOSE 9090

# Copy application code
COPY . .

# Set default command

# Install Foxglove Studio Bridge
RUN pip3 install foxglove-bridge

# Expose Foxglove port
EXPOSE 9090
CMD roslaunch gazebo_ros empty_world.launch & rosrun teleop_twist_keyboard teleop_twist_keyboard.py & foxglove-bridge
