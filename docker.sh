#! /bin/bash

set -e

SRC_DIR=`pwd`
CONTAINER_NAME="tf-gpu"
#IMAGE_NAME="gcr.io/tensorflow/tensorflow:latest-gpu"
IMAGE_NAME="mihailrc/tf-gpu"

if [ "$(docker ps -a | grep ${CONTAINER_NAME})" ]; then
  echo "Attaching to running container"
  nvidia-docker exec -it ${CONTAINER_NAME} bash $@
else
  nvidia-docker run --name ${CONTAINER_NAME} --rm -it -p 8888:8888  -v "${SRC_DIR}:/deepLearning" ${IMAGE_NAME} $@
fi
