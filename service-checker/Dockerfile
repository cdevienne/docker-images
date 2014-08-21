#
# Curl site check dockerfile
#
# http://github.com/marclennox/docker-images/service-checker
#

# Pull base image.
FROM debian:wheezy

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Install packages.
RUN apt-get update
RUN apt-get install -y curl wget

# Define working directory.
WORKDIR /data

# Add the script files
ADD ./script /data/script
