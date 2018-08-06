#!/bin/bash
/usr/bin/php artisan migrate --seed
/etc/init.d/supervisor start
supervisorctl reread && supervisorctl update
