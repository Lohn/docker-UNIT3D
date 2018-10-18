FROM debian:stretch
RUN apt-get update
RUN apt-get install -y curl apt-transport-https lsb-release ca-certificates git tmux wget zip unzip build-essential python2.7 libpng-dev
RUN echo "deb http://nginx.org/packages/debian/ stretch nginx" >> /etc/apt/sources.list
RUN echo "deb-src http://nginx.org/packages/debian/ stretch nginx" >> /etc/apt/sources.list
RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update
RUN apt-get install -y supervisor redis-server nginx
RUN apt-get install -y php-pear php7.2-curl php7.2-dev php7.2-gd php7.2-mbstring php7.2-zip php7.2-mysql php7.2-xml php7.2-fpm php7.2-intl
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g laravel-echo-server
RUN sed -i "s|cgi.fix_pathinfo=1|cgi.fix_pathinfo=0 |g" /etc/php/7.2/fpm/php.ini
RUN service php7.2-fpm restart

WORKDIR /var/www/html
RUN git clone https://github.com/HDInnovations/UNIT3D.git .
RUN chown -R www-data: storage bootstrap public config && find . -type d -exec chmod 0755 '{}' + -or -type f -exec chmod 0644 '{}' +
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
RUN cp .env.example .env
RUN wget -q -O /tmp/libpng12.deb http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb && dpkg -i /tmp/libpng12.deb && rm /tmp/libpng12.deb
RUN composer install && composer require predis/predis && npm install && npm install --save-dev socket.io-client && npm run dev

RUN php artisan key:generate

RUN chown -R www-data: storage bootstrap public config
COPY default /etc/nginx/conf.d/default.conf
RUN sed -i "s|user  nginx;|user  www-data; |g" /etc/nginx/nginx.conf
COPY laravel-echo-server.json /var/www/html/laravel-echo-server.json
COPY unit3d.conf /etc/supervisor/conf.d/unit3d.conf
COPY startup.sh /bin/startup.sh
RUN chmod +x /bin/startup.sh
ENTRYPOINT ["/bin/startup.sh"]
