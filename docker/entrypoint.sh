#!/bin/bash
set -e

# Si no existe el archivo .env, copiarlo desde .env.example
if [ ! -f /var/www/.env ]; then
    cp /var/www/.env.example /var/www/.env
fi

# Corrige el formato del archivo .env en caso de que APP_KEY esté pegada a HOST.
# Esta expresión busca líneas que comiencen con "HOST=" seguido de una IP (dígitos y puntos)
# y que inmediatamente tengan "APP_KEY=", insertando un salto de línea entre ambas.
sed -i 's/^\(HOST=[0-9.]\+\)APP_KEY=/\1\nAPP_KEY=/' /var/www/.env

# Forzar la presencia de la variable APP_KEY en el .env (por si no existiera)
if ! grep -q "^APP_KEY=" /var/www/.env; then
    echo "APP_KEY=" >> /var/www/.env
fi

# Cambiar propietario y permisos del archivo .env para que sea modificable
chown root:www-data /var/www/.env
chmod 664 /var/www/.env

# Extraer el valor de APP_KEY (lo que esté después del '=')
APP_KEY_VALUE=$(grep "^APP_KEY=" /var/www/.env | cut -d '=' -f2-)

# Si APP_KEY está vacía, generar la clave
if [ -z "$APP_KEY_VALUE" ]; then
    echo "Generando APP_KEY..."
    php artisan key:generate --force
fi

# Ajustar permisos para storage y bootstrap/cache
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Inicia PHP-FPM y Nginx
php-fpm &
nginx -g "daemon off;"
