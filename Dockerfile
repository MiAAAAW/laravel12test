##############################
# ETAPA 1: Construcción (builder)
##############################
FROM composer:2 AS builder
WORKDIR /app

# Copiar archivos de Composer y descargar las dependencias sin paquetes de desarrollo
COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-scripts --no-progress

# Copiar el resto del código de la aplicación
COPY . .

# Optimizar la configuración de Laravel (cache de config, rutas y vistas)
RUN php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache

##############################
# ETAPA 2: Imagen Final para Producción
##############################
FROM php:8.2-fpm-alpine
WORKDIR /var/www

# Instalar dependencias de desarrollo para compilar GD y demás extensiones
RUN apk add --no-cache \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libwebp-dev \
    zlib-dev

# Configurar e instalar la extensión GD y las extensiones de PDO para MySQL
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp && \
    docker-php-ext-install gd pdo pdo_mysql

# Copiar los archivos construidos desde la etapa builder
COPY --from=builder /app /var/www

# Ajustar permisos en directorios críticos de Laravel
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Exponer el puerto (ajusta según tu configuración, por ejemplo 8080 o 9000)
EXPOSE 8080

# Comando para iniciar PHP-FPM
CMD ["php-fpm"]
