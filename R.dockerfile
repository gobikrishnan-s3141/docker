# Base ubuntu LTS image - R dev 
FROM ubuntu:latest
# FROM r-base:latest [debian based R-image by rocker community]

# install system dep
RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential\
	cmake \
	clang \
	llvm \
	r-base \
	r-base-dev \
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
	&& rm -rf /var/lib/apt/lists/*

## set up env to use clang (experimental)
#ENV CC=clang
#ENV CXX=clang++

# install core & required R pkgs
RUN R -e "install.packages(c( \
	'BiocManager', \
	'tidyverse', \
	'devtools', \
	'rmarkdown', \
	'shiny', \
	'remote' \
	), repos ='https://cloud.r-project.org/')"

RUN R -e "BiocManager::install(c( \
	'GenomicRanges', \
	'Biostrings', \
	'DESeq2', \
	'edgeR', \
	'limma', \
	'SingleCellExperiment', \
	'scater' \
	))"

# user (for better security, never run as root)
RUN groupadd bioinfo && useradd -m -G bioinfo rmonk
USER rmonk

# workspace
RUN mkdir -p ~/analysis
WORKDIR ~/analysis && chown -R rmonk:bioinfo ~/analysis

# R
CMD ["R"]

#(or)
# rserver
#EXPOSE 8787
#docker-compose-yml (write a separate yml file) 
