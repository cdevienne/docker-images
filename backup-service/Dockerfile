#
# Ruby backup gem service dockerfile
#
# http://github.com/marclennox/docker-images/backup-service
#

# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:latest

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Remove OS cron jobs
RUN rm -f /etc/cron.daily/*

# Install base packages.
RUN apt-get update
RUN apt-get -y install \
    build-essential \
    curl \
    git-core \
    libcurl4-openssl-dev \
    libreadline-dev \
    libssl-dev \
    libsqlite3-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    mysql-client \
    sqlite3 \
    wget \
    zlib1g-dev

# Add postgresql client from official source.
RUN \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
  wget https://www.postgresql.org/media/keys/ACCC4CF8.asc && \
  apt-key add ACCC4CF8.asc && \
  apt-get update && \
  apt-get -y install libpq-dev postgresql-client-9.3 postgresql-contrib-9.3

# Compile redis from official source
RUN \
  cd /tmp && \
  wget http://download.redis.io/releases/redis-2.8.13.tar.gz && \
  tar -xzvf redis-*.tar.gz && \
  rm -f redis-*.tar.gz && \
  cd redis-* && \
  make && \
  make install && \
  cd .. && \
  rm -rf redis-*

# Define working directory.
WORKDIR /tmp

# Compile ruby from source.
RUN \
  wget http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz && \
  tar -xzvf ruby-*.tar.gz && \
  rm -f ruby-*.tar.gz && \
  cd ruby-* && \
  ./configure --disable-install-doc && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-*

# Install ruby gems.
RUN gem install activesupport backup rubygems-update whenever --no-ri --no-rdoc

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define working directory.
WORKDIR /opt/backups

# Add the entrypoint script
ADD . /opt/backups

# Define mountable directories.
VOLUME ["/data"]

# Define entrypoint script.
ENTRYPOINT ["./script/docker-entrypoint.sh"]

# Define default command.
CMD ["/sbin/my_init"]
