# server : debian-base
FROM debian:latest

# install system dep
RUN apt-get update -y && apt-get install -y curl \
	nginx \
	locales && \
	apt-get purge && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# Set working directory 
WORKDIR /app

# Copy necessary files
COPY . .

# Expose necessary ports
EXPOSE 80

# Set environment variables
ENV NODE_ENV=production

# Run your server application
CMD ["nginx", "-g", "daemon off;"]
