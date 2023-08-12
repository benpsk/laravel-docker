#!/usr/bin/env bash

ROLE=${ROLE:-app}
APPENV=${APPENV:-production}

if [ $ROLE == "app" ]; then
    if [ $APPENV == "production" ]; then
        echo "Running production tasks."
        php /usr/bin/composer install --optimize-autoloader --no-dev
        php artisan optimize:clear
        php artisan optimize

        echo "Running assets."
        npm install --omit=dev
        npm run build

    else
        echo "Running tasks."
        php /usr/bin/composer install
        php artisan optimize:clear

        echo "Running assets."
        npm install
        npm run dev --host=0.0.0.0 &
    fi
fi

chown -R www-data:www-data storage
chown -R www-data:www-data bootstrap/cache
