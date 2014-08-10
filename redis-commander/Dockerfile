#
# Redis Commander Dockerfile
#
# http://github.com/marclennox/docker-images
#

# Pull base image.
FROM debian:wheezy

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Install packages.
RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv wget

# Compile node from source.
RUN \
  cd /tmp && \
  wget http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-*.tar.gz && \
  rm -f node-*.tar.gz && \
  cd node-* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/node-v*

# Install node packages.
RUN npm install -g redis-commander

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
ENTRYPOINT ["redis-commander"]

# Expose ports
EXPOSE 8081
