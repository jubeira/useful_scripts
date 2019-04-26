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
RUN apt update && apt install -y curl sudo tmux bash-completion gnupg2 lsb-core

# Install extra packages
RUN apt update && apt install -y python3-argcomplete

# ROS setup sources
RUN curl http://repo.ros2.org/repos.key | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://repo.ros2.org/ubuntu/main `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'

RUN apt update && apt install -y \
  build-essential \
  cmake \
  git \
  python3-colcon-common-extensions \
  python3-lark-parser \
  python3-pip \
  python-rosdep \
  python3-vcstool \
  wget

# install some pip packages needed for testing
RUN python3 -m pip install -U \
  argcomplete \
  flake8 \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest \
  pytest-cov \
  pytest-runner \
  setuptools

# install Fast-RTPS dependencies
RUN apt install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev

# Get ROS2 sources from master
WORKDIR /ros2_ws
RUN mkdir -p /ros2_ws/src
RUN wget https://raw.githubusercontent.com/ros2/ros2/master/ros2.repos
RUN vcs import src < ros2.repos

RUN rosdep init
RUN rosdep update && rosdep install --from-paths src --ignore-src --rosdistro crystal -y --skip-keys "console_bridge fastcdr fastrtps libopensplice67 libopensplice69 rti-connext-dds-5.3.1 urdfdom_headers"

# Extra RMW implementations
# RUN apt update && apt install libopensplice69
# RUN apt install -q -y rti-connext-dds-5.3.1  # from packages.ros.org/ros2/ubuntu

# RUN cd /opt/rti.com/rti_connext_dds-5.3.1/resource/scripts && . ./rtisetenv_x64Linux3gcc5.4.0.sh; cd - && colcon build --symlink-install

# Create a user with passwordless sudo
RUN adduser --gecos "Development User" --disabled-password juan
RUN adduser juan sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo "export QT_X11_NO_MITSHM=1" >> /home/juan/.bashrc

USER juan

WORKDIR /home/juan
