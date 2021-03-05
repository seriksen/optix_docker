FROM nvidia/cuda:11.0-devel-centos7

ENV CUDA_VERSION=11.0
ENV CUDA_VERSION_D=11-0
ENV CUDA_SUBVERSION=.3-1
ENV NsightCompute_version=2019.3

ARG OPTIX_VERSION=6.0.0
ENV OPTIX_VERION=${OPTIX_VERSION}

# Setup
RUN yum -y update
RUN yum -y install sudo

# Set bash
SHELL ["/bin/bash", "-c"]

# Set user
ENV DOCKER_USER="sam"
RUN useradd -ms /bin/bash --groups wheel ${DOCKER_USER}
RUN echo "${DOCKER_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $DOCKER_USER
WORKDIR /home/${DOCKER_USER}

# Standard dependencies
RUN sudo -n yum -y install xorg-x11-apps.x86_64 \
 	                   xauth \
          	           pciutils \
                       lshw \
                       epel-release \
                       wget \
                       zip \
                       unzip \
	                   git \
	                   libXcursor-devel \
                	   libXinerama-devel \
                	   libXrandr-devel \
                	   mesa-dri-drivers \
                	   mesa-libGLES \
                	   mesa-libGLw \
                	   mesa-libGLw-devel \
                	   freeglut-devel \
                	   freeglut \
                	   expat-devel \
                	   doxygen \
                	   libXmu-devel \
                	   libXi-devel \
                	   libGL-devel \
                	   curl-devel \
                	   openssl-devel
# Non-yum installs
ENV INSTALL_BASE=/home/$DOCKER_USER
ENV CUDA_SAMPLES_DIR ${INSTALL_BASE}/cuda-samples
ENV RUNTIME_BASE="/usr/local"

# NVIDIA Cuda
RUN mkdir ${CUDA_SAMPLES_DIR} && cd ${CUDA_SAMPLES_DIR}
ENV PATH=${INSTALL_BASE}/cuda-${CUDA_VERSION}/bin:${INSTALL_BASE}/cuda-${CUDA_VERSION}/NsightCompute-${NsightCompute_version}${PATH}
ENV LD_LIBRARY_PATH=/usr/lib64:/usr/lib:${INSTALL_BASE}/cuda-${CUDA_VERSION}/lib64:${LD_LIBRARY_PATH}
RUN cuda-install-samples-${CUDA_VERSION}.sh .

# Install NVIDIA OptiX
ENV OptixVersion NVIDIA-OptiX-SDK-${OPTIX_VERSION}-linux64
ENV OptixInstallScript ${OptixVersion}-25650775.sh

ENV OPTIX_ENTRY_DIR="${INSTALL_BASE}/optix"
ENV OPTIX_RUNTIME_DIR="${RUNTIME_BASE}/optix"

RUN sudo -E env PATH=${PATH} mkdir -p ${OPTIX_ENTRY_DIR} && \
    sudo -E env PATH=${PATH} mkdir -p ${OPTIX_RUNTIME_DIR} && \
    sudo -E env PATH=${PATH} chmod 777 ${OPTIX_RUNTIME_DIR}

COPY ${OptixInstallScript} ${OPTIX_ENTRY_DIR}

RUN cd ${OPTIX_ENTRY_DIR} && yes | bash ${OptixInstallScript} --prefix=${OPTIX_RUNTIME_DIR}

ENV LD_LIBRARY_PATH=${OPTIX_ENTRY_DIR}/${OptixVersion}/SDK-precompiled-samples:${LD_LIRARY_PATH:+:${LD_LIBRARY_PATH}}

RUN sudo chmod 777 /home/${DOCKER_USER}