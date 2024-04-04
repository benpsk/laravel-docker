ARG VERSION

FROM php:${VERSION}-fpm

ARG VERSION

WORKDIR /var/www/html

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Asia/Yangon

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies # Install PHP extensions
RUN apt-get update && apt-get install -y \
    git curl \
    libpng-dev libonig-dev libxml2-dev \
    zip unzip libzip-dev libsodium-dev \
    gnupg supervisor cron \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd \
    zip sodium

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Node.js lts version and NPM, supervisor and cron
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - &&\
    apt-get install -y nodejs

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY php.ini /usr/local/etc/php/php.ini
COPY start-container.sh /usr/local/bin/start-container.sh
COPY laravel-worker.conf /etc/supervisor/conf.d/laravel-worker.conf
COPY my_cron_tab /etc/cron.d/my_cron_tab

RUN chmod +x /usr/local/bin/start-container.sh

ENTRYPOINT [ "start-container.sh" ]