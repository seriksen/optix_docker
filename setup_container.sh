#!/bin/bash

container-name(){
  echo optix_desktop
}

build-optix() {

  docker build --no-cache=true -t $(container-name) .
}

push-optix() {

  if [ $# -eq 0 ]
  then
  tag="latest"
  else
  tag=$1
  fi
  echo "Pushing docker image with tag = $tag"

  docker push sameriksen/$(container-name):${tag}
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
