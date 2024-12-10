# ubuntu base 
FROM ubuntu:rolling

# install system dep
RUN apt-get update &&  apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
        python3 \
        python3-dev \
        python3-pip \
        wget \
        curl \
        git \
        libopenblas-dev \
        gfortran \
        pkg-config \
        libhdf5-dev\
        && rm -rf /var/lib/apt/lists/*

# user
RUN groupadd bioinfo && useradd -m -G bioinfo bmonk
USER bmonk

# workspace
RUN mkdir -p ~/analysis
WORKDIR ~/analysis && chown -R bmonk:bioinfo ~/analysis

# launch a shell
CMD ["sh"]
