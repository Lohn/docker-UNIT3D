#!bin/bash
/usr/bin/php artisan migrate --seed
service supervisorctl start
supervisorctl reread && supervisorctl update
