#
# Docker drone dockerfile
#
# http://github.com/marclennox/docker-images/docker-drone
#

# Pull base image.
FROM ubuntu:trusty

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Install packages.
RUN apt-get update
RUN apt-get install -y apparmor curl make build-essential bzr git libsqlite3-dev mercurial sqlite3 wget

# Install golang from source.
RUN \
  cd /opt && \
  hg clone -u release https://code.google.com/p/go && \
  cd go/src && \
  ./make.bash

# Setup go path.
ENV GOROOT /opt/go
ENV PATH $PATH:/opt/go

# Install drone from debian package.
RUN wget http://downloads.drone.io/latest/drone.deb
RUN dpkg -i drone.deb

# Install Docker in Docker
RUN curl -s https://get.docker.io/ubuntu/ | sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add files to the container.
ADD . /opt/drone
ADD script/wrap-docker.sh /usr/local/bin/

# Set the working directory.
WORKDIR /opt/drone

# Set the entrypoint script.
ENTRYPOINT ["script/docker-entrypoint.sh"]

# Set default command.
EXPOSE 8080

# Expose volumes.
VOLUME ["/var/lib/drone"]

CMD ["/usr/local/bin/droned", "--port=:8080", "--datasource=/var/lib/drone/drone.sqlite"]
