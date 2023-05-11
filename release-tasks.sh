ROLE=${ROLE:-app}
APPENV=${APPENV:-production}

if [ $ROLE == "app" ]; then
    if [ $APPENV == "production" ]; then
        echo "Running production tasks."
        php /usr/bin/composer install --optimize-autoloader --no-dev
        php artisan optimize:clear
    else
        echo "Running tasks."
        php /usr/bin/composer install
        php artisan optimize:clear
    fi
fi

chown -R www-data:www-data storage
chown -R www-data:www-data bootstrap/cache