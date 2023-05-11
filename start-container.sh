#!/usr/bin/env bash

ROLE=${ROLE:-app}
APPENV=${APPENV:-production}

echo "App running on $APPENV environment."

if [ $ROLE == "app" ]; then
    echo "App started"
    /usr/local/bin/release-tasks.sh
    /usr/local/sbin/php-fpm -F
elif [ $ROLE == "queue" ]; then
    echo "Queue started."
    php artisan queue:work
elif [ $ROLE == "scheduler" ]; then
    echo "Scheduler started."
    php artisan schedule:work
    # while [ true ]
    # do
    #     php artisan inspire && sleep 30
    #     # php artisan schedule:run --verbose --no-interaction && sleep 60
    # done
else
    echo "Unknown Role."
    exit 1
fi
