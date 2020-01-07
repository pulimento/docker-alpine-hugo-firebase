FROM mhart/alpine-node:12
MAINTAINER Javi Pulido <pulimento@gmail.com>

ENV HUGO_VERSION 0.62.2
ENV HUGO_EXTENDED_BINARY hugo_extended_${HUGO_VERSION}_Linux-64bit

# Install Firebase tools
RUN npm install -g firebase-tools

# Download and install hugo
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_EXTENDED_BINARY}.tar.gz /tmp/hugo.tar.gz
RUN mkdir /usr/local/hugo \
	&& tar xzf /tmp/hugo.tar.gz -C /usr/local/hugo/ \
	&& ln -s /usr/local/hugo/hugo /usr/local/bin/hugo \
	&& rm /tmp/hugo.tar.gz
