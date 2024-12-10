# ubuntu LTS base - python dev
FROM ubuntu:latest
# FROM python:3.13-slim-bullseye [pre-built debian-base python env] 

# reduce package overhead
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# install dependencies
RUN apt-get update &&  apt-get install -y --no-install-recommends \
	build-essential \
	gcc \
	python3 \
	python3-dev \
	python3-pip \
	vim \
	wget \
	curl \
	git \
	libopenblas-dev \
	gfortran \
	pkg-config \
	libhdf5-dev\
	&& rm -rf /var/lib/apt/lists/*

# user (for better security, don't run as root)
RUN groupadd bioinfo && useradd -m -G bioinfo pymonk
USER pymonk

# workspace
RUN mkdir -p ~/analysis
WORKDIR ~/analysis && chown -R bioinfo:pymonk ~/analysis

# python pkgs
#COPY requirements.txt ./               # (always specify exact version for python packages) 
#RUN python3 -m venv 0env && source 0env/bin/activate && pip3 install --no-cache-dir \ 
#        biopython \
#        numpy \
#        pandas \
#        scipy \
#        jupyter

# python
CMD ["python3"]
# (or, if you want to use jupyter notebook)
# jupyter notebook
#EXPOSE 8888
#CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
