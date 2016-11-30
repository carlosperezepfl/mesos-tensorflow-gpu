FROM nvidia/cuda:8.0-cudnn5-devel

# Based on container from Craig Citro <craigcitro@google.com>
MAINTAINER Carlos Perez <carlos.perez@epfl.ch>

# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

RUN pip --no-cache-dir install \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        scipy \
        sklearn \
        Pillow \
        && \
    python -m ipykernel.kernelspec

# Fixed version
# Install TensorFlow GPU version.
RUN pip --no-cache-dir install \
    https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.12.0rc0-cp27-none-linux_x86_64.whl

# Wrapper for TFBoard
COPY run.sh /

# Change TFBoard port to $PORT0
CMD ["/run.sh"]
