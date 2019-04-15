#!/usr/bin/env bash

IMAGE=ros2_dashing_bionic_desktop

pushd "$( dirname "${BASH_SOURCE[0]}" )"
docker build -t ${IMAGE} .
popd
