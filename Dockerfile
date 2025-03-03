# Etapa de construcción: instala las dependencias sin paquetes de desarrollo
FROM composer:2 AS builder
WORKDIR /app

# Copiar archivos de Composer y descargar las dependencias
COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-scripts --no-progress

# Copiar el resto del código de la aplicación
COPY . .

# Opcional: optimizar la configuración de Laravel
RUN php artisan config:cache && php artisan route:cache && php artisan view:cache

# Etapa final: prepara la imagen de producción con PHP-FPM
FROM php:8.1-fpm-alpine
WORKDIR /var/www

# Instalar dependencias del sistema necesarias para algunas extensiones
RUN apk add --no-cache libpng libjpeg-turbo libwebp freetype

# Configurar e instalar la extensión gd y las extensiones de PDO para MySQL
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp && \
    docker-php-ext-install gd pdo pdo_mysql

# Copiar los archivos construidos desde la etapa anterior
COPY --from=builder /app /var/www

# Ajustar permisos para directorios críticos de Laravel
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

EXPOSE 8080
CMD ["php-fpm"]
