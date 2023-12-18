FROM php:8.0-apache 

ENV DB_HOST "localhost"
ENV DB_NAME "name"
ENV DB_USER "user"
ENV DB_PASSWORD "password"

WORKDIR /var/www/html
COPY php-files/* ./

RUN docker-php-ext-install pdo pdo_mysql

EXPOSE 80