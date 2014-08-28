#
# Wordpress base dockerfile
#
# http://github.com/marclennox/wordpress-base/backup-service
#

# Pull base image.
FROM debian:jessie

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Install packages.
RUN \
  apt-get update && \
  apt-get -y install php5-fpm php5-mysql

# Transform configurations.
RUN \
  sed -i -r 's/^(\s*[;]?\s*cgi\.fix_pathinfo\s*[=].*)$/; \1\ncgi.fix_pathinfo=0/' /etc/php5/fpm/php.ini && \
  sed -i -r 's/^(\s*[;]?\s*error_log\s*[=].*)$/; \1\nerror_log = error.log/' /etc/php5/fpm/php-fpm.conf && \
  sed -i -r 's/^(\s*[;]?\s*daemonize\s*[=].*)$/; \1\ndaemonize = no/' /etc/php5/fpm/php-fpm.conf && \
  sed -i -r 's/^(\s*[;]?\s*user\s*[=].*)$/; \1\nuser = root/' /etc/php5/fpm/pool.d/www.conf && \
  sed -i -r 's/^(\s*[;]?\s*group\s*[=].*)$/; \1\ngroup = root/' /etc/php5/fpm/pool.d/www.conf && \
  sed -i -r 's/^(\s*[;]?\s*listen\s*[=].*)$/; \1\nlisten = 9000/' /etc/php5/fpm/pool.d/www.conf && \
  sed -i -r 's/^(\s*[;]?\s*listen\.owner\s*[=].*)$/; \1/' /etc/php5/fpm/pool.d/www.conf && \
  sed -i -r 's/^(\s*[;]?\s*listen\.group\s*[=].*)$/; \1/' /etc/php5/fpm/pool.d/www.conf

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define working directory.
WORKDIR /data

# Define mountable directories.
VOLUME ["/data"]

# Define default command.
CMD ["php5-fpm", "-c", "/etc/php5/fpm/php.ini", "-y", "/etc/php5/fpm/php-fpm.conf", "-R"]

# Expose ports
EXPOSE 9000
