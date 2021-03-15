#!/bin/bash

container-name(){
  echo optix
}

build-optix() {

  docker build -no-cache=true -t $(container-name) .
}


run-optix() {

  # Get optiX libraries
  #centos_search_loc=/usr/lib64/*
  search_loc=/usr/lib64/*
  optix_libs=$(find ${search_loc} | grep -i optix)
  rt_libs=$(find ${search_loc} | grep -i rtcore)
  swrast_dri=$(find ${search_loc} | grep -i swrast )
  to_mount=""

  for vol in $optix_libs $rt_libs $swrast_dri
  do
  to_mount="$to_mount -v ${vol}:${vol}"
  done

  # Start the container
  docker run -it \
  --runtime=nvidia \
  --name=$(container_name) \
  --security-opt seccomp=unconfined \
  --init \
  --net=host \
  --rm=true \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /etc/localtime:/etc/localtime:ro \
  ${to_mount} \
  $(container-name)
}
