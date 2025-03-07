# Usar una imagen base oficial de PHP
FROM php:8.2-fpm

# Instalar extensiones de PHP necesarias para Laravel
RUN docker-php-ext-install pdo pdo_mysql

# Establecer el directorio de trabajo en el contenedor
WORKDIR /var/www

# Copiar los archivos de la aplicación al contenedor
COPY . .

# Instalar dependencias de Composer
RUN composer install

# Copiar el archivo de configuración de PHP personalizado
COPY php.ini /usr/local/etc/php/conf.d/php.ini

# Exponer el puerto en el que se ejecutará la aplicación
EXPOSE 9000

# Comando para ejecutar el contenedor
CMD ["php-fpm"]
