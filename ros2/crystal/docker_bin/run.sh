#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
REPO_ROOT=$SCRIPTPATH/../
IMAGE=ros2_crystal_bionic_desktop

if [ "$#" == 0 ]; then
  EXTRA_ARGS="bash"
else
  EXTRA_ARGS="bash -c \"$@\""
fi

docker run \
  -v ${HOME}:${HOME} \
  -it \
  ${IMAGE} "${EXTRA_ARGS}"

