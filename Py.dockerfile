# python-3 base image [pre-built debian-base python env]
 
FROM python:3.12-slim-bullseye

# reduce package overhead
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# install dependencies
RUN apt-get update &&  apt-get install -y --no-install-recommends \
	build-essential \
	python3 \
	python3-dev \
	python3-pip \
	curl \
	sudo \
	git \
	gfortran \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# user (for better security, don't run as root)
RUN useradd -m -s /bin/bash pymonk && \
    echo "pymonk:password" | chpasswd && \
    usermod -aG sudo pymonk
USER pymonk

# workspace
RUN mkdir -p ~/analysis && \
chown -R pymonk ~/analysis

WORKDIR ~/analysis

# python pkgs
#COPY requirements.txt ./               # (always specify exact version for python packages) 
#RUN python3 -m venv 0env && source 0env/bin/activate && \
RUN pip3 install --upgrade pip setuptools wheel && pip3 install --no-cache-dir biopython \
        numpy \
        pandas \
	scipy \
        jupyter
# For R integration, install `r-base` and pip install rpy2 
# python
CMD ["python3"]
# (or, if you want to use jupyter notebook)
# jupyter notebook
#EXPOSE 8888
#CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
