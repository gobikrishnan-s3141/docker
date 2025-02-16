# server : debian-base (slim-minimal overhead)
FROM debian:bookworm-slim

# environment var for server
ENV DEBIAN_FRONTEND=non-interactive \
    TZ=Etc/UTC

# install system dep
RUN apt-get update -y && apt-get install -y build-essential \
	apt-utils \
	ca-certificates \
	wget \
	curl \
	gnupg2 \
	tmux \
	openssh-client \
	cron \
	sudo \
	vim \
	htop \
	net-tools \
	dnsutils \
	locales && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* 

# Set working directory 
WORKDIR /srv

# create a non-root user with sudo prervileges
RUN useradd -m -s /bin/bash admin && \
    echo "admin:password" | chpasswd && \
    usermod -aG sudo admin

# Copy necessary files * (do not copy everything on the dir, use dockerignore)
# COPY . .
# or use VOLUME for shared resources between host and container
# VOLUME ["/var/log", "/srv/data"]

# Expose ports
EXPOSE 80 443 22 8080

# Set a default command
CMD ["bash", "-c", "tail -f /dev/null"]
