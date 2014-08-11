#
# Rails App Base Dockerfile
#
# http://github.com/marclennox/docker-images/rails-app-base
#

# Pull base image.
FROM ubuntu:trusty

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Install packages.
RUN \
  apt-get update && \
  apt-get -y install \
    build-essential \
    curl \
    git-core \
    libcurl4-openssl-dev \
    libpq-dev \
    libreadline-dev \
    libssl-dev \
    libsqlite3-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    mysql-client \
    postgresql-client-9.3 \
    python \
    python-dev \
    python-pip \
    python-software-properties \
    python-virtualenv \
    sqlite3 \
    wget \
    zlib1g-dev

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

# Compile ruby from source.
RUN \
  cd /tmp && \
  wget http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz && \
  tar -xzvf ruby-*.tar.gz && \
  rm -f ruby-*.tar.gz && \
  cd ruby-* && \
  ./configure && \
  make && \
  make install && \
  cd /tmp && \
  rm -rf /tmp/ruby-*

# Install ruby gems.
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN gem install awesome_print bundler rubygems-update

# Setup ruby and gem config.
RUN \
  echo "require 'awesome_print'" > ~/.irbrc && \
  echo "" > ~/.irbrc && \
  echo "require 'AwesomePrint.irb!'" >> ~/.irbrc && \
  echo "" > ~/.irbrc && \
  echo "IRB.conf[:SAVE_HISTORY] = 100" >> ~/.irbrc && \
  echo "IRB.conf[:HISTORY_FILE] = \"#{ENV['HOME']}/.irb-history\"" >> ~/.irbrc

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data
