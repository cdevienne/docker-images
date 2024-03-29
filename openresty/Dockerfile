#
# Openresty dockerfile
#
# This docker contains openresty (nginx) compiled from source with useful optional modules installed.
#
# http://github.com/marclennox/docker-images/openresty
#

# Pull base image.
FROM debian:jessie

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Install packages.
RUN apt-get update
RUN apt-get install -y build-essential curl libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl wget

# Compile pcre from source.
RUN \
  wget http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz && \
  tar zxvf pcre-*.tar.gz && \
  rm -f pcre-*.tar.gz && \
  cd pcre-* && \
  ./configure && \
  make && \
  make install && \
  make clean && \
  cd .. && \
  rm -rf pcre-* && \
  ln -s /usr/local/lib/libpcre.so.1 /lib64

# Compile openresty from source.
RUN \
  wget http://openresty.org/download/ngx_openresty-1.7.2.1.tar.gz && \
  tar -xzvf ngx_openresty-*.tar.gz && \
  rm -f ngx_openresty-*.tar.gz && \
  cd ngx_openresty-* && \
  ./configure && \
  make && \
  make install && \
  make clean && \
  cd .. && \
  rm -rf ngx_openresty-* && \
  ln -s /usr/local/openresty/nginx/sbin/nginx /usr/local/bin/nginx

# Add files to the container.
ADD ./script/ /usr/local/bin

# Expose volumes.
VOLUME ["/etc/nginx"]

# Set the working directory.
WORKDIR /etc/nginx

# Set the entrypoint script.
ENTRYPOINT ["docker-entrypoint"]

# Define the default command.
CMD ["nginx", "-c", "/etc/nginx/nginx.conf"]
