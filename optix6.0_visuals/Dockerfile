FROM nvidia/cudagl:10.2-devel-centos7

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
                           libGLU-devel \
                           curl-devel \
                           openssl-devel \
                           terminator

# Virtual GL and TurboVNC and Desktop
RUN sudo yum -y install https://downloads.sourceforge.net/project/virtualgl/2.6.3/VirtualGL-2.6.3.x86_64.rpm \
                        gdm \
                        https://downloads.sourceforge.net/project/turbovnc/2.2.4/turbovnc-2.2.4.x86_64.rpm

RUN sudo yum -y groupinstall "X Window System" \
                             "Xfce"

# Copy in OptiX
ENV OptixInstallScript NVIDIA-OptiX-SDK-6.0.0-linux64-25650775.sh
COPY ${OptixInstallScript} /home/${DOCKER_USER}

# Start visuals
CMS /bin/bash
#CMD /opt/TurboVNC/bin/vncserver -vgl -wm xfce4-session
