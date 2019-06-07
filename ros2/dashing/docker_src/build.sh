#!/usr/bin/env bash

IMAGE=ros2_dashing_bionic_source

pushd "$( dirname "${BASH_SOURCE[0]}" )"
./dashing_base/build.sh
docker build -t ${IMAGE} . $@
popd
