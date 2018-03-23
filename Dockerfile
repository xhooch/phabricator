FROM phusion/baseimage:0.10.0
MAINTAINER Alexander Serkov <sal@e96.ru>

RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php && \
    echo "Asia/Yekaterinburg" > /etc/timezone

# install packages
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    php7.1-cli \
    php7.1-fpm \
    php7.1-curl \
    php7.1-json \
    php7.1-mysql \
    php7.1-mcrypt \
    php7.1-soap \
    php7.1-mbstring \
    php7.1-xml \
    php7.1-bcmath \
    php7.1-zip \
    php7.1-imap \
    php7.1-intl \
    php-xdebug \
    php-apcu php-apcu-bc \
    php-imagick php-memcache \
    nginx \
    git \
    && phpdismod xdebug \
    && ln -s /etc/php/7.1 /etc/php/current \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker/nginx.sh /etc/service/nginx/run
COPY docker/php-fpm.sh /etc/service/php-fpm/run

# configure php
COPY docker/php/fpm/ /etc/php/7.1/fpm/
COPY docker/php/php-cli.ini /etc/php/7.1/cli/php.ini
RUN mkdir /var/log/fpm && chown www-data:www-data /var/log/fpm

COPY docker/init.d/ /etc/my_init.d/

# configure nginx
COPY docker/nginx/ /etc/nginx/

COPY docker/bin /usr/local/bin

# Phb
RUN mkdir phabricator && \
    git clone https://www.github.com/phacility/libphutil.git /var/www/phabricator/libphutil && \
    git clone https://www.github.com/phacility/arcanist.git /var/www/phabricator/arcanist && \
    git clone https://www.github.com/PHPOffice/PHPExcel.git /var/www/phabricator/PHPExcel

ADD . /var/www/phabricator/phabricator

WORKDIR /var/www

EXPOSE 80 443 22 24