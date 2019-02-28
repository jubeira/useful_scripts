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

RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  git \
  python3-colcon-common-extensions \
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
  git+https://github.com/lark-parser/lark.git@0.7b \
  pytest-repeat \
  pytest-rerunfailures
# [Ubuntu 16.04] install extra packages not available or recent enough on Xenial
RUN python3 -m pip install -U \
  pytest \
  pytest-cov \
  pytest-runner \
  setuptools
# install Fast-RTPS dependencies
RUN apt install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev

WORKDIR /ros2_ws
RUN mkdir -p /ros2_ws/src
RUN wget https://raw.githubusercontent.com/ros2/ros2/release-latest/ros2.repos
RUN vcs import src < ros2.repos

RUN rosdep init
RUN rosdep update && rosdep install --from-paths src --ignore-src --rosdistro bouncy -y --skip-keys "console_bridge fastcdr fastrtps libopensplice67 rti-connext-dds-5.3.1 urdfdom_headers"
RUN colcon build --symlink-install

WORKDIR /shared_ws
