#!/bin/bash
set -e

# Si no existe el archivo .env, se copia desde .env.example
if [ ! -f /var/www/.env ]; then
    cp /var/www/.env.example /var/www/.env
fi

# Cambia la propiedad y permisos del archivo .env para que sea modificable
chown root:www-data /var/www/.env
chmod 664 /var/www/.env

# Verifica si APP_KEY está definida y no está vacía; si no, genera una nueva clave
if ! grep -q "^APP_KEY=" /var/www/.env || grep -q "^APP_KEY=\s*$" /var/www/.env; then
    echo "Generando APP_KEY..."
    php artisan key:generate --force
fi

# Ajusta permisos para storage y bootstrap/cache
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Inicia PHP-FPM en segundo plano
php-fpm &

# Inicia Nginx en primer plano
nginx -g "daemon off;"
