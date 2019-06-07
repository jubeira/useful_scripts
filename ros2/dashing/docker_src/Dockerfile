FROM ros2_dashing_bionic_base

# Get ROS2 sources from master
WORKDIR /ros2_ws
RUN sudo chown juan -R /ros2_ws
RUN mkdir -p /ros2_ws/src
# Master / release-latest: choose one.
# RUN wget https://raw.githubusercontent.com/ros2/ros2/master/ros2.repos
RUN wget https://raw.githubusercontent.com/ros2/ros2/release-latest/ros2.repos
RUN vcs import src < ros2.repos

RUN sudo rosdep init && sudo apt update
RUN rosdep update && rosdep install --from-paths src --ignore-src --rosdistro dashing -y --skip-keys "console_bridge fastcdr fastrtps libopensplice67 libopensplice69 rti-connext-dds-5.3.1 urdfdom_headers"

# Extra RMW implementations
# RUN apt update && apt install libopensplice69
# RUN apt install -q -y rti-connext-dds-5.3.1  # from packages.ros.org/ros2/ubuntu

# RUN cd /opt/rti.com/rti_connext_dds-5.3.1/resource/scripts && . ./rtisetenv_x64Linux3gcc5.4.0.bash; cd - && colcon build --symlink-install

WORKDIR /home/juan
