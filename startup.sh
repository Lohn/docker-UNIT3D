#!/bin/bash
sed -i "s|DB_HOST=.*|DB_HOST=$DB_HOST |g" .env
sed -i "s|DB_DATABASE=.*|DB_DATABASE=$DB_DATABASE |g" .env
sed -i "s|DB_USERNAME=.*|DB_USERNAME=$DB_USERNAME |g" .env
sed -i "s|DB_PASSWORD=.*|DB_PASSWORD=$DB_PASSWORD |g" .env
sed -i "s|APP_URL=.*|APP_URL=$APP_URL |g" .env
if [ $INITIALIZE -eq 1]
then
/usr/bin/php artisan migrate --seed
fi
/etc/init.d/supervisor start
supervisorctl reread && supervisorctl update
/bin/bash
