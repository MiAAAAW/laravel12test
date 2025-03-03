# Imagen base con PHP-FPM
FROM php:8.2-fpm

# Instalar extensiones y dependencias para Laravel + Nginx
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nginx \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instalar Composer (desde la imagen oficial)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Directorio de trabajo
WORKDIR /var/www

# Copiar Composer e instalar dependencias
COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-scripts --no-progress

# Copiar el resto del proyecto
COPY . .

# Ajustar permisos (si lo requieres)
RUN chown -R www-data:www-data /var/www

# Copiar configuración de Nginx y el script de entrada
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expones el puerto 8080 (Nginx escucha en 8080)
EXPOSE 8080

# El CMD iniciará Nginx y PHP-FPM
CMD ["/entrypoint.sh"]
