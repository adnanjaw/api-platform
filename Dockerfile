ARG PHP_IMAGE_VERSION=${PHP_IMAGE_VERSION}

FROM php:${PHP_IMAGE_VERSION}-fpm-bookworm AS local

# Good practice to have labels for maintainer
LABEL maintainer="Adnan Al Jawabra"

# Use ARG for variables that should be customizable at build time
ARG UID=${UID:-10000}
ARG GID=${GID:-10001}
ARG USER=${USER:-api}

# Create a non-root user and group with the specified UID/GID
RUN groupadd --gid $GID $USER && \
    useradd --uid $UID --gid $GID --create-home --shell /bin/bash $USER

# Copy configuration files
COPY .docker/php/conf.d $PHP_INI_DIR/conf.d/
COPY .docker/php/php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.${USER}.conf

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Use multi-stage builds to copy only the necessary binaries
COPY --from=composer:2.5 /usr/bin/composer /usr/local/bin/composer
COPY --from=mlocati/php-extension-installer:1.5 /usr/bin/install-php-extensions /usr/local/bin/

# Set environment variables
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install PHP extensions using the installer script
RUN install-php-extensions mysqli pdo_mysql exif gd imagick imap opcache soap zip intl gettext sysvsem amqp redis pcntl

# Install system dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    nano \
    zip \
    unzip \
    ffmpeg \
    mkvtoolnix \
    libimage-exiftool-perl

# Clean up the apt cache to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /api

# Switch to the non-root user
USER $USER