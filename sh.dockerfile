# alpine linux - minimal server/workstation
FROM alpine:latest

# install dependencies
RUN apk update && apk add --no-cache \
    bash \
    curl \
    wget \
    git \
    libgcc \
    musl-dev \
    python3 \
    py3-pip

# add non-root user (for better security)
RUN adduser -D -h /home/shmonk shmonk && \
chown -R shmonk /home/shmonk
USER shmonk

# workspace
RUN mkdir ~/scripts
WORKDIR ~/scripts

#shell
CMD ["sh"]
