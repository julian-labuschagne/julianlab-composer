###
# Download and build composer
###

FROM php:7.3.11-apache-stretch
MAINTAINER Julian Labuschagne "julian.labuschagne@gmail.co.za"
ENV REFRESHED_AT 2021-01-08

WORKDIR /var/www/html

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      wget \
      git-core \
      unzip \
      libfreetype6-dev \
      libjpeg62-turbo-dev \
      libpng-dev \
      libzip-dev

RUN docker-php-ext-install -j$(nproc) opcache mysqli pdo_mysql zip && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd

COPY conf/composer/ /var/www/html/

RUN sh install-composer.sh && mv composer.phar /usr/local/bin/composer && rm install-composer.sh

CMD ["/usr/local/bin/composer"]

VOLUME /var/www/html