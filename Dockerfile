FROM debian:testing-slim

MAINTAINER Brian Winkers <bwinkers@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
  curl git php7.1  php7.1-mysql gcc libpcre3-dev php7.1-dev \    
  && apt-get autoremove

RUN git clone --depth=1 "git://github.com/phalcon/cphalcon.git" \
  && cd cphalcon/build \
  && ./install

COPY config/php.ini /usr/local/etc/php/

COPY src/ /var/www/html/


