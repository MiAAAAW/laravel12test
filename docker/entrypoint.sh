#!/bin/bash
set -e

# 1. Si no existe el archivo .env, copiar el .env.example
if [ ! -f /var/www/.env ]; then
    cp /var/www/.env.example /var/www/.env
fi

# 2. Generar APP_KEY si no está definida o está vacía
if ! grep -q "^APP_KEY=" /var/www/.env || grep "^APP_KEY=\s*$" /var/www/.env; then
    echo "Generando APP_KEY..."
    php artisan key:generate --force
fi

# 3. Ajustar permisos para que storage y bootstrap/cache sean escribibles
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# 4. Inicia PHP-FPM en segundo plano
php-fpm &

# 5. Inicia Nginx en primer plano
nginx -g "daemon off;"
