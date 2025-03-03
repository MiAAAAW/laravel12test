# Usamos PHP-FPM (8.2) como base
FROM php:8.2-fpm

# Instalar dependencias necesarias para Laravel y Nginx
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    nginx \
 && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instalar Composer desde la imagen oficial de Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo
WORKDIR /var/www

# Copia los archivos de Composer e instala las dependencias
COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-scripts --no-progress

# Copia el resto de la aplicación Laravel
COPY . .

# Ajusta permisos para que Laravel pueda escribir en storage y cache
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Copia la configuración de Nginx y el script de arranque
# Asegúrate de tener estos archivos en un directorio llamado "docker" en la raíz
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exponemos el puerto 8080 (Nginx escuchará en ese puerto)
EXPOSE 8080

# El entrypoint se encargará de generar la clave y arrancar los servicios
CMD ["/entrypoint.sh"]
