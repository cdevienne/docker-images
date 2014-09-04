#
# Curl site check dockerfile
#
# http://github.com/marclennox/docker-images/service-checker
#

# Pull base image.
FROM debian:jessie

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Install packages.
RUN apt-get update
RUN apt-get install -y curl wget

# Define working directory.
WORKDIR /opt/service-checker

# Copy files in place.
ADD . /opt/service-checker

# Define mountable directories.
VOLUME ["/data"]

# Set default command.
CMD ["./script/http-connect-wait.sh"]