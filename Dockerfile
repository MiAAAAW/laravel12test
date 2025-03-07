# Usar una imagen base oficial de PHP
FROM php:8.2-fpm

# Instalar extensiones de PHP necesarias para Laravel
RUN docker-php-ext-install pdo pdo_mysql

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Establecer el directorio de trabajo en el contenedor
WORKDIR /var/www

# Copiar los archivos de la aplicación al contenedor
COPY . .

# Instalar dependencias de Composer
RUN composer install

# Exponer el puerto en el que se ejecutará la aplicación
EXPOSE 9000

# Comando para ejecutar el contenedor
CMD ["php-fpm"]
