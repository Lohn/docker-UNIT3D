#!/bin/bash
cp .env.example .env
sed -i "s|DB_HOST=127.0.0.1|DB_HOST=$DB_HOST |g" .env
sed -i "s|DB_DATABASE=unit3d|DB_DATABASE=$DB_DATABASE |g" .env
sed -i "s|DB_USERNAME=homestead|DB_USERNAME=$DB_USERNAME |g" .env
sed -i "s|DB_PASSWORD=secret|DB_PASSWORD=$DB_PASSWORD |g" .env
sed -i "s|APP_URL=http://unit3d.site|APP_URL=$APP_URL |g" .env
if [ $INITIALIZE -eq 1]
then
/usr/bin/php artisan migrate --seed
fi
/etc/init.d/supervisor start
supervisorctl reread && supervisorctl update
/bin/bash
