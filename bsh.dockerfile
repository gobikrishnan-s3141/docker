# ubuntu base - minimal bioinformatics workstation 
FROM ubuntu:rolling

# install system dep
RUN apt-get update &&  apt-get install -y --no-install-recommends \
        build-essential \
        python3 \
        python3-dev \
        python3-pip \
        curl \
        git \
        gfortran \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# user
RUN groupadd bioinfo && \
useradd -m -G bioinfo bmonk
USER bmonk

# workspace
RUN mkdir -p ~/analysis && \
    chown -R bmonk:bioinfo ~/analysis
WORKDIR ~/analysis

# launch a shell
CMD ["sh"]
