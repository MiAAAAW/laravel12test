#!/bin/bash
set -e

# Si no existe el archivo .env, copia el ejemplo
if [ ! -f /var/www/.env ]; then
    cp /var/www/.env.example /var/www/.env
fi

# Si APP_KEY no está definida o está vacía, genera una nueva clave
if ! grep -q "^APP_KEY=" /var/www/.env || grep "^APP_KEY=\s*$" /var/www/.env; then
    echo "Generando APP_KEY..."
    php artisan key:generate --force
fi

# Asegurar permisos en storage y bootstrap/cache
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Inicia PHP-FPM en segundo plano (escuchará en 127.0.0.1:9000)
php-fpm &

# Inicia Nginx en primer plano para mantener el contenedor activo
nginx -g "daemon off;"
