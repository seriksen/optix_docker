# Optix 6.0

## Using
```bash
container_name=optix
# Build
docker build -t ${container_name} .

# Run 1
docker run --runtime=nvidia --gpus all -it --rm ${container_name} /bin/bash
## failure
[sam@ac2f0b03b905 SDK-precompiled-samples]$ ./optixHello --file test     
OptiX Error: 'Failed to load OptiX library 
(/root/sw/wsapps/raytracing/rtsdk/rel6.5/samples_sdk/optixHello/optixHello.cpp:90)' 

# Run 2
# mount directly
docker run \
-v /usr/lib64/libnvoptix.so.1:/usr/lib64/libnvoptix.so.1 \
-v /usr/lib64/libnvoptix.so.440.33.01:/usr/lib64/libnvoptix.so.440.33.01 \
-v /usr/lib64/libnvidia-rtcore.so.440.33.01:/usr/lib64/libnvidia-rtcore.so.440.33.01 \
--runtime=nvidia --name optix -it --rm --cap-add SYS_PTRACE ${container_name} /bin/bash
## failure
[sam@38419ea64925 SDK-precompiled-samples]$ ./optixHello --file hello.pbm 

OptiX Error: 'Unknown error (Details: Function "RTresult _rtContextLaunch2D(RTcontext, unsigned int, RTsize, RTsize)" caught exception: Encountered a rtcore error: m_api.pipelineCreate( context, pipelineOptions, compileOptions, modules, moduleCount, pipeline ) returned (8): Link error) 

(/root/sw/wsapps/raytracing/rtsdk/rel6.5/samples_sdk/optixHello/optixHello.cpp:108)' 

# Run 3
docker run --runtime=nvidia -e  NVIDIA_DRIVER_CAPABILITIES=graphics --rm -it --gpus all ${container_name} /bin/bash
## failure
# nvidia-smi not recongised so..
[sam@59c9e696415b SDK-precompiled-samples]$ ./optixHello --file hello.pbm
OptiX Error: 'A supported NVIDIA GPU could not be found
(/root/sw/wsapps/raytracing/rtsdk/rel6.5/samples_sdk/optixHello/optixHello.cpp:90)'
```

gpu01 has optix libraries at `/usr/lib64/libnvoptix.so libnvidia-rtcore.so.440.33.01  `
