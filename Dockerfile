FROM php:8.1-fpm-buster AS local

LABEL maintainer="Adnan Al Jawabra (github.com/adnanjaw)"

ARG UID=${UID:-10000}
ARG GID=${GID:-10001}
ARG USER=${USER:-api}

RUN addgroup \
    --gid $GID \
    --system $USER \
    && adduser \
    --uid $UID \
    --disabled-password \
    --gecos "" \
    --ingroup $USER \
    --no-create-home \
    $USER

COPY .docker/php/conf.d $PHP_INI_DIR/conf.d/

COPY .docker/php/php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.${USER}.conf

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY --from=composer:2.5 /usr/bin/composer /usr/local/bin/composer

COPY --from=mlocati/php-extension-installer:1.5 /usr/bin/install-php-extensions /usr/local/bin/

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN install-php-extensions mysqli pdo_mysql exif gd imagick imap opcache soap zip intl gettext sysvsem amqp redis pcntl

RUN apt-get update && apt-get install -y \
    software-properties-common  \
    nano \
    zip \
    unzip \
    ffmpeg \
    mkvtoolnix \
    libimage-exiftool-perl

WORKDIR /api