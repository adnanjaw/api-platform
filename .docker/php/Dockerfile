ARG PHP_IMAGE_VERSION=${PHP_IMAGE_VERSION}

FROM t0shy/phpfpm-bookworm-ffmpeg:${PHP_IMAGE_VERSION} AS dev

LABEL maintainer="Adnan Al Jawabra"

# Use ARG for variables that should be customizable at build time
ARG UID=${UID:-10000}
ARG GID=${GID:-10001}
ARG USER=${USER:-api}

# Create a non-root user and group with the specified UID/GID
RUN groupadd --gid $GID $USER && \
    useradd --uid $UID --gid $GID --create-home --shell /bin/bash $USER

# Copy configuration files
COPY ./conf.d $PHP_INI_DIR/conf.d/
COPY ./php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.${USER}.conf

# Clean up the apt cache to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /api

# Switch to the non-root user
USER $USER