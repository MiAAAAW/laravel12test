#!/bin/bash
# Inicia PHP-FPM en segundo plano
php-fpm &

# Inicia Nginx en primer plano
nginx -g "daemon off;"
