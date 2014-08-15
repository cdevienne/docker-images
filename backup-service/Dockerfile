#
# Ruby backup gem service dockerfile
#
# http://github.com/marclennox/docker-images/backup-service
#

# Pull base image.
FROM debian:wheezy

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Install base packages.
RUN apt-get update
RUN apt-get -y install \
    build-essential \
    cron \
    curl \
    git-core \
    libcurl4-openssl-dev \
    libreadline-dev \
    libssl-dev \
    libsqlite3-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    wget \
    zlib1g-dev

# Define working directory.
WORKDIR /tmp

# Compile ruby from source.
RUN \
  wget http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz && \
  tar -xzvf ruby-*.tar.gz && \
  rm -f ruby-*.tar.gz && \
  cd ruby-* && \
  ./configure --disable-install-doc && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-*

# Install ruby gems.
RUN gem install backup rubygems-update whenever --no-ri --no-rdoc

# Define working directory.
WORKDIR /data

# Define mountable directories.
VOLUME ["/data"]

# Define default command.
CMD ["cron", "-f"]
