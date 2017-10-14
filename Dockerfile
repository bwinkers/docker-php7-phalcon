FROM php:7.1-fpm

MAINTAINER Brian Winkers <bwinkers@gmail.com>

RUN apt-get update && apt-get install -y \
        git libpq-dev

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

RUN docker-php-ext-install pdo pdo_pgsql

RUN echo 'extension=pgsql.so' >> /usr/local/etc/php/php.ini

RUN git clone --depth=1 "git://github.com/phalcon/cphalcon.git" \
  && cd cphalcon/build \
  && ./install

RUN echo 'extension=phalcon.so' >> /usr/local/etc/php/php.ini

RUN git clone "git://github.com/phalcon/phalcon-devtools.git" \
  && cd phalcon-devtools \
  && ./phalcon.sh \
  && . /root/.bashrc

COPY src/ /var/www/html/



