# FROM php:8-apache 
# RUN apt-get update && apt-get install -y \
#   imagemagick \
#   libfreetype6-dev \
#   libjpeg62-turbo-dev \
#   libmagickwand-dev --no-install-recommends \
#   libpng-dev \
#   && rm -rf /var/lib/apt/lists/* \
#   && a2enmod rewrite \
#   && docker-php-ext-install exif \
#   && docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install -j$(nproc) gd \
#   && pecl install imagick && docker-php-ext-enable imagick \
#   && docker-php-ext-install mysqli \
#   && docker-php-ext-install pdo pdo_mysql

FROM php:8-apache

RUN a2enmod rewrite

RUN set -xe \
    && apt-get update \
    && apt-get install -y libpng-dev libjpeg-dev libmcrypt-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mbstring mysqli zip \
    && pecl install mcrypt-1.0.4 \
    && docker-php-ext-enable mcrypt

WORKDIR /var/www/html

# COPY ./ssl/*.pem /etc/apache2/ssl/
# COPY ./apache/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN apt-get update && apt-get install -y \
  # imagemagick \
  # libfreetype6-dev \
  # libjpeg62-turbo-dev \
  # libmagickwand-dev --no-install-recommends \
  # libpng-dev \
  # && rm -rf /var/lib/apt/lists/* \
  # && a2enmod rewrite \
  # && docker-php-ext-install exif \
  # && docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install -j$(nproc) gd \
  # && pecl install imagick && docker-php-ext-enable imagick \
  && docker-php-ext-install mysqli \
  && docker-php-ext-install pdo pdo_mysql
RUN chown -R www-data:www-data /var/www
RUN whoami
EXPOSE 80
EXPOSE 443
