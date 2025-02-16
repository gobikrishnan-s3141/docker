# Base image with Ubuntu LTS
FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Install system dependencies and core tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    software-properties-common \
    apt-utils \
    cmake \
    git \
    wget \
    curl \
    unzip \
    bzip2 \
    gzip \
    pigz \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libncurses5-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libopenblas-dev \
    libhdf5-dev \
    openjdk-21-jdk \
    python3-dev \
    python3-pip \
    r-base \
    r-base-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create biouserrmatics user
RUN useradd -m -s /bin/bash biouser && \
    echo "biouser:biouser" | chpasswd && \
    usermod -aG sudo biouser
USER biouser

RUN mkdir -p ~/analysis 
WORKDIR ~/analysis

# Install Python packages
ENV PATH="/home/biouser/.local/bin:$PATH"
RUN pip install --upgrade pip setuptools wheel && \
    pip install \
    numpy scipy pandas matplotlib seaborn \
    jupyterlab notebook ipywidgets \
    biopython pysam pyvcf cyvcf2 \
    scanpy anndata scrublet cellrank \
    deeptools pybigwig pybedtools \
    multiqc snakemake

# Install R packages
RUN R -e "install.packages(c('tidyverse', 'devtools', 'BiocManager', 'rmarkdown', 'knitr'))" && \
    R -e "BiocManager::install(c('DESeq2', 'edgeR', 'limma', 'ComplexHeatmap', 'clusterProfiler', 'GSVA', 'GenomicRanges', 'rtracklayer'))"

# Install bioinformatics tools via conda
ENV CONDA_DIR=/home/biouser/miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    bash miniconda.sh -b -p $CONDA_DIR && \
    rm miniconda.sh
ENV PATH="$CONDA_DIR/bin:$PATH"

RUN conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda install -y \
    fastqc multiqc \
    samtools bcftools htslib \
    bowtie2 bwa star hisat2 \
    gatk4 picard \
    vcftools plink2 \
    bedtools ucsc-bedgraphtobigwig \
    blast entrez-direct \
    trimmomatic fastp \
    snpeff annovar \
    igv

# Install workflow managers
RUN pip install nextflow && \
    curl -s https://get.nextflow.io | bash && \
    mv nextflow $CONDA_DIR/bin/

# Install genome browsers and visualization tools
RUN conda install -y igv ucsc-genebrowser && \
    pip install pyensembl pyfaidx

# Configure workspace
RUN mkdir -p /home/biouser/workspace/{data,results,scripts,references}
#VOLUME /home/biouser/workspace

# Configure security
RUN echo "auth-minimum-user-id=1000" >> /etc/rstudio/rserver.conf && \
    echo "server-pid-file=/var/run/rstudio-server.pid" >> /etc/rstudio/rserver.conf

# Expose ports
EXPOSE 8787 8888 60151

# Switch back to biouser user
USER biouser

# Default command
CMD ["bash", "-c", "tail -f /dev/null"]
