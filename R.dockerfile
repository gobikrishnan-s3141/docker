# Base R image
FROM r-base:latest

# install system dep 
RUN apt-get update && apt-get install -y --no-install-recommends \
	libcurl4-openssl-dev \
	libssl-dev \
	libxml2-dev \
	libfontconfig1-dev \
	libharfbuzz-dev \
	libfribidi-dev \
	libfreetype6-dev \
	libpng-dev \
	libtiff5-dev \
	libjpeg-dev \
	&& rm -rf /var/lib/apt/lists/*

# install core & required R pkgs
RUN R -e "install.packages(c( \
	'BiocManager', \
	'tidyverse', \
	'devtools', \
	'rmarkdown', \
	'shiny', \
	'remote' \
	), repos ='https://cloud.r-project.org/')"

RUN -e "BiocManager::install(c( \
	'GenomicRanges', \
	'Biostrings', \
	'DESeq2', \
	'edgeR', \
	'limma', \
	'SingleCellExperiment', \
	'scater' \
	))"

# user (for better security, never run as root)
RUN adduser -S rmonk && adduser -S rmonk -G rmonk

# workspace
RUN mkdir -p ~/analysis
WORKDIR ~/analysis && chown -R rmonk:rmonk ~/analysis

# R
CMD["R"]

#(or)
# rserver
#EXPOSE 8787
#docker-compose-yml (write a separate yml file) 
