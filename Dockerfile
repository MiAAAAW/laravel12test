# Usa una imagen de PHP con FPM
FROM php:8.2-fpm

# Instala dependencias necesarias para Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
 && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instala Composer (usando la imagen de composer)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# Copia archivos de Composer e instala las dependencias
COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-scripts --no-progress

# Copia el resto del código de Laravel
COPY . .

# Ajusta permisos (según necesites)
RUN chown -R www-data:www-data /var/www

# Expone el puerto en el que PHP-FPM escucha (usualmente 9000)
EXPOSE 9000

# Inicia PHP-FPM
CMD ["php-fpm"]
