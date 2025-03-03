FROM php:8.2-fpm

# Instalar dependencias para Laravel y Nginx
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    nginx \
 && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# Copiar archivos de Composer e instalar dependencias
COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-scripts --no-progress

# Copiar el resto del proyecto Laravel
COPY . .

# Ajustar permisos para storage y bootstrap/cache
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache && \
    chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Copiar configuración de Nginx y el entrypoint
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exponer el puerto 8080 (Nginx escucha en 8080 en el contenedor)
EXPOSE 8080

CMD ["/entrypoint.sh"]
