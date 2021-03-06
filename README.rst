optix_docker
============

Dockerfile for creating docker images for use with Nvidia OptiX.

Dockerfile overview
-------------------

Base image: :code:`nvidia/cudagl`

* CentOS 7
* NVidia Cuda 10.2
* NVidia OptiX (6.0.0, 6.5.0, 7.0.0)

Usage
-----

.. code-block:: sh

    source setup_container.sh
    build-optix
    run-optix

Build args;

* Optix Build Version. Set by :code:`optix=`
* Docker user. Set by :code:`user=`

eg; :code:`build-optix optix=NVIDIA-OptiX-SDK-7.0.0.sh user=sam`

Misc
----
This approach was inspired by `recipe-wizard <https://github.com/trn84/recipe-wizard>`_ which creates Dockerfiles which
need to run OpenGL applications on headless remote servers.


