FROM php:7.3-fpm

WORKDIR /apps

RUN apt update \
&& apt install zip unzip wget

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

RUN wget https://getcomposer.org/composer.phar

EXPOSE 80 

CMD php -S 0.0.0.0:80 -t public
