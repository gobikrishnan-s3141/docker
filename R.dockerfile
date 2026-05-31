# r-ver image from rocker [debian based R-image by rocker community]
FROM rocker/r-ver:4.6.0

# avoids prompting during installation
ENV DEBIAN_FRONTEND=noninteractive

# install system dep
RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential\
	cmake \
	gfortran \
	git \
	sudo \
	libomp-dev \
	curl \
	libopenblas-dev \
	libcurl4-openssl-dev \
	libssl-dev \
	libxml2-dev \
	libcairo2-dev \
	libxt-dev \
	libfontconfig1-dev \
	libharfbuzz-dev \
	libfribidi-dev \
	libfreetype6-dev \
	libpng-dev \
	libtiff5-dev \
	libjpeg-dev \
	zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
# install R pkgs for your project / use renv / {rix}
	R -e "install.packages(c('BiocManager', \
	'tidyverse', \
	'devtools' \
	), repos ='https://cloud.r-project.org/')" && \

	R -e "BiocManager::install(c('DESeq2', \
	'limma', \
	'SingleCellExperiment'\
	))"

# user (for better security, never run as root)
RUN useradd -m -s /bin/bash rmonk
USER rmonk

# workspace
RUN mkdir -p /home/rmonk/analysis
WORKDIR /home/rmonk/analysis

# R
CMD ["R"]

#(or)
# rserver
# FROM rocker/rstudio
#EXPOSE 8787
#docker-compose-yml (write a separate yml file)
