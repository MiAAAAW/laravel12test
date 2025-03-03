# Imagen base con PHP-FPM
FROM php:8.2-fpm

# Instalar extensiones y dependencias para Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nginx \
 && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instalar Composer desde la imagen oficial
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Configurar directorio de trabajo
WORKDIR /var/www

# Copiar archivos de Composer y instalar dependencias de Laravel
COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-scripts --no-progress

# Copiar el resto de la aplicación
COPY . .

# Ajustar permisos (según necesidad)
RUN chown -R www-data:www-data /var/www

# Copiar configuración de Nginx (debes crear este archivo)
COPY docker/nginx.conf /etc/nginx/nginx.conf

# Exponer el puerto 80 (servido por Nginx)
EXPOSE 8080

# Usar un script de entrada para iniciar ambos servicios
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
