#!/usr/bin/env bash

IMAGE=bionic_nvidia

pushd "$( dirname "${BASH_SOURCE[0]}" )"
docker build -t ${IMAGE} . $@
popd
