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
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd \
    zip sodium

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Node.js lts version and NPM
RUN apt-get update && apt-get install -y ca-certificates curl gnupg supervisor \ 
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install nodejs -y

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY php.ini /etc/php/${VERSION}/cli/conf.d/php.ini 
COPY start-container.sh /usr/local/bin/start-container.sh
COPY laravel-worker.conf /etc/supervisor/conf.d/laravel-worker.conf

RUN chmod +x /usr/local/bin/start-container.sh

ENTRYPOINT [ "start-container.sh" ]
