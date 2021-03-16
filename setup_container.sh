#!/bin/bash

container-name(){
  echo optix_docker
}

build-optix() {
  if [ $# -eq 0 ]
  then
    docker build --no-cache=true -t $(container-name) .
  else
    docker build --no-cache=true -t $(container-name) --build-arg optix=$1 .
  fi
}

run-optix() {

  # Get optiX libraries
  #centos_search_loc=/usr/lib64/*
  search_loc=/usr/lib64/*
  optix_libs=$(find ${search_loc} | grep -i optix)
  rt_libs=$(find ${search_loc} | grep -i rtcore)
  swrast_dri=$(find ${search_loc} | grep -i swrast )

  optix_mounts=""
  for vol in $optix_libs $rt_libs $swrast_dri
  do
  optix_mounts="$optix_mounts -v ${vol}:${vol}"
  done

  # Start the container
  docker run -it \
  --runtime=nvidia \
  --name=$(container-name) \
  --security-opt seccomp=unconfined \
  --init \
  --net=host \
  --rm=true \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /etc/localtime:/etc/localtime:ro \
  ${optix_mounts} \
  $(container-name)
}
