#!/bin/bash

container-name(){
  echo optix
}

build-optix() {

  docker build -t $(container-name) .
}


run-optix() {
#centos_search_loc=/usr/lib64/*
search_loc=/usr/lib64/*
optix_libs=$(find ${search_loc} | grep -i optix)
rt_libs=$(find ${search_loc} | grep -i rtcore)

to_mount=""

for vol in $optix_libs $rt_libs
do
to_mount="$to_mount -v ${vol}:${vol}"
done

echo "Starting optix container with 1 GPU"

#docker run ${to_mount} --rm --runtime=nvidia -it --gpus 1 $(container-name) /bin/bash
docker run --rm --runtime=nvidia -it --gpus 1 $(container-name) /bin/bash
}
