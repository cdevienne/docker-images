#
# Rails App Base Dockerfile
#
# http://github.com/marclennox/docker-images/rails-app-base
#

# Pull base image.
FROM debian:wheezy

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Define working directory.
WORKDIR /tmp

# Install base packages.
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
    python \
    python-dev \
    python-pip \
    python-software-properties \
    python-virtualenv \
    sqlite3 \
    wget \
    zlib1g-dev

# Add postgresql client from official source.
RUN \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
  wget https://www.postgresql.org/media/keys/ACCC4CF8.asc && \
  apt-key add ACCC4CF8.asc && \
  apt-get update && \
  apt-get -y install postgresql-client-9.3 postgreql-contrib-9.3

# Compile node from source.
RUN \
  wget http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-*.tar.gz && \
  rm -f node-*.tar.gz && \
  cd node-* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd .. && \
  rm -rf ./node-v*

# Compile ruby from source.
RUN \
  wget http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz && \
  tar -xzvf ruby-*.tar.gz && \
  rm -f ruby-*.tar.gz && \
  cd ruby-* && \
  ./configure && \
  make && \
  make install && \
  cd .. && \
  rm -rf ./ruby-*

# Install ruby gems.
RUN gem install bundler rubygems-update --no-ri --no-rdoc

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data
