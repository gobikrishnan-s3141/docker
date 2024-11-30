# debian base - python dev
FROM python:3.13-slim-bullseye

# reduce package overhead
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# install dependencies
RUN apt-get update &&  apt-get install -y --no-install-recommends \
	build-essential \
	gcc \
	wget \
	curl \
	git \
	libopenblas-dev \
	gfortran \
	pkg-config \
	libhdf5-dev\
	&& rm -rf /var/lib/apt/lists/*

# python pkgs
#COPY requirements.txt ./		# (always specify exact version for python packages) 
RUN pip install --no-cache-dir \ 
	biopython \
	numpy \
	pandas \
	scipy \
	jupyter

# user (for better security, don't run as root)
RUN addgroup -S pymonk && adduser -S pymonk -G pymonk
USER pymonk

# workspace
RUN mkdir -p ~/analysis
WORKDIR ~/analysis && chown -R pymonk:pymonk ~/analysis

# python
CMD ["python3"]
# (or, if you want to use jupyter notebook)
# jupyter notebook
#EXPOSE 8888
#CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
