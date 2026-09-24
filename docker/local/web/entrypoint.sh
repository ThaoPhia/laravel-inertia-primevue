#!/bin/sh
set -e

if [ ! -f /var/www/data/database.sqlite ]; then
    touch /var/www/data/database.sqlite
    chown www-data:www-data /var/www/data/database.sqlite
fi

php artisan migrate --force

exec "$@"
