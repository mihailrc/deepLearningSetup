FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

LABEL maintainer="Mihail Chirita <mihailrc@google.com>"

# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        python3-setuptools\
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python3 \
        python3-pip \
        python3-dev \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 --no-cache-dir install \
        Pillow \
        h5py \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        pandas \
        scipy \
        tqdm \
        sklearn \
        tensorflow-gpu


# For CUDA profiling, TensorFlow requires CUPTI.
# TODO figure out how to install CUPTI
# ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH

# Set up jupyter
COPY jupyter_config.py /root/.jupyter/
COPY jupyter_run.sh /deepLearning/

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

WORKDIR "/deepLearning"

CMD ["/deepLearning/jupyter_run.sh", "--allow-root"]
