#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
REPO_ROOT=$SCRIPTPATH/../
IMAGE=ros2_dashing_bionic_desktop

if [ "$#" == 0 ]; then
  EXTRA_ARGS="bash"
else
  EXTRA_ARGS="bash -c \"$@\""
fi

xhost +
docker run \
  --net=host -e DISPLAY=${DISPLAY} -v /dev:/dev \
  -v ${HOME}:${HOME} \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  --privileged \
  -it \
  ${IMAGE} "${EXTRA_ARGS}"
