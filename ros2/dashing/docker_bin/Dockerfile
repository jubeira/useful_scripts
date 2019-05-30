FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04

# Setup nvidia runtime
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
   ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# Setup environment
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

# Install basic packages
RUN apt update && apt install -y sudo tmux bash-completion

# Install extra packages
RUN apt update && apt install -y python3-argcomplete

# ROS2 Dashing basic deps and packages (testing debs)
RUN apt update && apt-get install -y curl gnupg2 lsb-release
RUN curl http://repo.ros2.org/repos.key | apt-key add -
#RUN sh -c 'echo "deb [arch=amd64] http://packages.ros.org/ros2-testing/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN sh -c 'echo "deb [arch=amd64] http://repo.ros2.org/ubuntu/testing `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN apt-get update && apt-get install ros-dashing-rclcpp ros-dashing-examples* ros-dashing-demos* ros-dashing-ros2* python3-colcon-common-extensions -y

# ROS Melodic stuff
# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
# RUN apt-get update && apt-get install ros-melodic-ros-base -y

# Create a user with passwordless sudo
RUN adduser --gecos "Development User" --disabled-password juan
RUN adduser juan sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo "export QT_X11_NO_MITSHM=1" >> /home/juan/.bashrc

USER juan
WORKDIR /home/juan

