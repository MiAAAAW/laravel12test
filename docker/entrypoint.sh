#!/bin/bash

# Inicia PHP-FPM en segundo plano (escuchando en 127.0.0.1:9000)
php-fpm &

# Inicia Nginx en primer plano
nginx -g "daemon off;"
