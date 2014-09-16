#
# Memcached dockerfile
#
# http://github.com/marclennox/docker-images/memcached
#

# Pull base image.
FROM debian:jessie

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Install packages.
RUN apt-get update
RUN apt-get install -y build-essential libevent-dev wget

# Define working directory.
WORKDIR /tmp

# Compile node from source.
RUN \
  wget -O memcached-latest.tar.gz http://memcached.org/latest && \
  tar xvzf memcached-*.tar.gz && \
  rm -f memcached-*.tar.gz && \
  cd memcached-* && \
  ./configure && \
  make && \
  make install && \
  cd .. && \
  rm -rf memcached-*

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define working directory.
WORKDIR /data

# Define mountable directories.
VOLUME ["/data"]

# Define the entrypoint script.
ENTRYPOINT ["/usr/local/bin/memcached"]

# Define the command script.
CMD ["-u", "root", "-m", "64"]

# Expose ports.
EXPOSE 11211
