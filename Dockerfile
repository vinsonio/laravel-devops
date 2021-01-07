# Set the base image for subsequent instructions
FROM php:7.4-fpm-alpine

# Update packages
RUN apk update \
    && apk upgrade

# Install PHP and composer dependencies
RUN apk add --no-cache git \
    curl \
    libbz2 \
    libzip \
    zlib \
    openssh-client \
    libpng \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    zlib-dev

# Install needed extensions
RUN docker-php-ext-install bcmath \
    mysqli \
    pdo \
    pdo_mysql \
    gd
    # zip

# Install & enable Xdebug for code coverage reports
RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN apk del libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    zlib-dev \
    libxpm-dev
    
# Install Composer
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require laravel/envoy
