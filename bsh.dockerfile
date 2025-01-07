# ubuntu base - minimal bioinformatics workstation 
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
        zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# user
RUN groupadd bioinfo && useradd -m -G bioinfo bmonk
USER bmonk

# workspace
RUN mkdir -p ~/analysis
WORKDIR ~/analysis && chown -R bmonk:bioinfo ~/analysis

# launch a shell
ENTRYPOINT ["sh"]
