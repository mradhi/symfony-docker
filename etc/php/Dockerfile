FROM php:fpm-alpine

SHELL ["/bin/ash", "-oeux", "pipefail", "-c"]

# timezone
ARG TZ

# composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer

RUN apk update && \
  apk add --update --no-cache --virtual=.build-dependencies \
    autoconf=~2.69 \
    gcc=~9.2 \
    g++=~9.2 \
    make=~4.2 \
    tzdata=2019c-r0 \
    git=~2.24 && \
  apk add --update --no-cache \
    icu-dev=~64.2 \
    libzip-dev=~1.5 \
    oniguruma-dev=~6.9 && \
  echo ${TZ} > /etc/timezone && \
  pecl install xdebug && \
  docker-php-ext-install intl pdo_mysql mbstring zip bcmath && \
  docker-php-ext-enable xdebug && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
  composer config -g process-timeout 3600

# Install and run supervisor
RUN apk add --no-cache supervisor

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
