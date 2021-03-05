FROM nvidia/cuda:10.2-devel-centos7

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

# Install NVIDIA OptiX
ENV OptixVersion NVIDIA-OptiX-SDK-${OPTIX_VERSION}-linux64
ENV OptixInstallScript ${OptixVersion}-25650775.sh


COPY ${OptixInstallScript} /home/${DOCKER_USER}

#
# To use Optix
# sudo yum install freeglut-3.0.0-8.el7.i686
#
#