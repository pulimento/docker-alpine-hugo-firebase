FROM node:lts-alpine
MAINTAINER Javi Pulido <pulimentoapps@gmail.com>

ENV HUGO_VERSION 0.120.4
ENV HUGO_EXTENDED_BINARY hugo_extended_${HUGO_VERSION}_Linux-64bit

# Install Firebase tools
RUN npm install -g firebase-tools

# Download and install hugo
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_EXTENDED_BINARY}.tar.gz /tmp/hugo.tar.gz
RUN mkdir /usr/local/hugo \
	&& tar xzf /tmp/hugo.tar.gz -C /usr/local/hugo/ \
	&& ln -s /usr/local/hugo/hugo /usr/local/bin/hugo \
	&& rm /tmp/hugo.tar.gz
	
# Trick because hugo is dynamically linked - see https://stackoverflow.com/a/35613430/1096905
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
