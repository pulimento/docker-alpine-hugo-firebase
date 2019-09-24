FROM ubuntu:latest
MAINTAINER pulimento@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -q update

# Add NodeJS PPA
RUN apt-get install -y curl ca-certificates
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Install packages
RUN apt-get install -y nodejs python-pygments git && rm -rf /var/lib/apt/lists/*

#RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

RUN npm install -g firebase-tools

# Download and install hugo
ENV HUGO_VERSION 0.56.3
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.deb

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} /tmp/hugo.deb
RUN dpkg -i /tmp/hugo.deb \
	&& rm /tmp/hugo.deb

# Create working directory
#RUN mkdir /usr/share/blog
#WORKDIR /usr/share/blog

# Expose default hugo port
#EXPOSE 1313

# Automatically build site
#ONBUILD ADD site/ /usr/share/blog
#ONBUILD RUN hugo -d /usr/share/nginx/html/

# By default, serve site
#ENV HUGO_BASE_URL http://localhost:1313
#CMD hugo server -b ${HUGO_BASE_URL} --bind=0.0.0.0
