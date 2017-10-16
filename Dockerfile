FROM php:7.1-fpm

MAINTAINER Brian Winkers <bwinkers@gmail.com>

RUN docker-php-source extract \
    && apt-get update && apt-get install -y \
        git libpq-dev libevent-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql opcache sockets \
    && pecl install event \
    && docker-php-ext-enable event \
    && echo 'extension=event.so' >> /usr/local/etc/php/php.ini \
    && git clone --depth=1 "git://github.com/phalcon/cphalcon.git" \
    && cd cphalcon/build \
    && ./install \
    && echo 'extension=phalcon.so' >> /usr/local/etc/php/php.ini \
    && docker-php-source delete \
    && cd ../.. \
    && rm -Rf cphalcon

COPY src/ /var/www/html/



