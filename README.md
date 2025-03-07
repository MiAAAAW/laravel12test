<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

<p align="center">
<a href="https://github.com/laravel/framework/actions"><img src="https://github.com/laravel/framework/workflows/tests/badge.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

## About Laravel

Laravel is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling. Laravel takes the pain out of development by easing common tasks used in many web projects, such as:

- [Simple, fast routing engine](https://laravel.com/docs/routing).
- [Powerful dependency injection container](https://laravel.com/docs/container).
- Multiple back-ends for [session](https://laravel.com/docs/session) and [cache](https://laravel.com/docs/cache) storage.
- Expressive, intuitive [database ORM](https://laravel.com/docs/eloquent).
- Database agnostic [schema migrations](https://laravel.com/docs/migrations).
- [Robust background job processing](https://laravel.com/docs/queues).
- [Real-time event broadcasting](https://laravel.com/docs/broadcasting).

Laravel is accessible, powerful, and provides tools required for large, robust applications.

## Learning Laravel

Laravel has the most extensive and thorough [documentation](https://laravel.com/docs) and video tutorial library of all modern web application frameworks, making it a breeze to get started with the framework.

You may also try the [Laravel Bootcamp](https://bootcamp.laravel.com), where you will be guided through building a modern Laravel application from scratch.

If you don't feel like reading, [Laracasts](https://laracasts.com) can help. Laracasts contains thousands of video tutorials on a range of topics including Laravel, modern PHP, unit testing, and JavaScript. Boost your skills by digging into our comprehensive video library.

## Laravel Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the [Laravel Partners program](https://partners.laravel.com).

### Premium Partners

- **[Vehikl](https://vehikl.com/)**
- **[Tighten Co.](https://tighten.co)**
- **[WebReinvent](https://webreinvent.com/)**
- **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
- **[64 Robots](https://64robots.com)**
- **[Curotec](https://www.curotec.com/services/technologies/laravel/)**
- **[Cyber-Duck](https://cyber-duck.co.uk)**
- **[DevSquad](https://devsquad.com/hire-laravel-developers)**
- **[Jump24](https://jump24.co.uk)**
- **[Redberry](https://redberry.international/laravel/)**
- **[Active Logic](https://activelogic.com)**
- **[byte5](https://byte5.de)**
- **[OP.GG](https://op.gg)**

## Configuration COOLIFY + LARAVEL ACORDING

# Configuración de Coolify en Environment Variables luego de cargar el GitHub de Laravel 12

Este documento describe las variables de entorno utilizadas en un proyecto **Laravel 12**, tal como se configurarían en **Coolify** después de cargar el repositorio desde GitHub. Además, se detalla la configuración de **Network** en Coolify para exponer y mapear los puertos correspondientes.

---

# Configuración de Network en Coolify

En la sección **Network** de Coolify, es necesario exponer y mapear el puerto en el que se ejecuta la aplicación. Por ejemplo, si tu aplicación corre en el puerto `8080`, podrías configurar:

- **Ports Exposed**: `8080`  
- **Ports Mappings**: `8080:8080`  

De esta forma, Coolify redirige las peticiones externas al puerto interno de la aplicación. Asegúrate de que tu aplicación Laravel esté escuchando en el puerto configurado (en este ejemplo, el 8080).

---

# Variables de Entorno PARA SUBIR ALSO ON COOLIFY MODULE

```bash
APP_DEBUG=true
APP_ENV=local
APP_FAKER_LOCALE=en_US
APP_FALLBACK_LOCALE=en
APP_KEY=base64:wXk3BYBatrOch/bQAkEuNcBTvED4qaPV7TtjX73tUy0=
APP_LOCALE=en
APP_MAINTENANCE_DRIVER=file
APP_NAME=Laravel
APP_URL=http://localhost:8081/

AWS_ACCESS_KEY_ID=
AWS_BUCKET=
AWS_DEFAULT_REGION=us-east-1
AWS_SECRET_ACCESS_KEY=
AWS_USE_PATH_STYLE_ENDPOINT=false

BCRYPT_ROUNDS=12
BROADCAST_CONNECTION=log
CACHE_STORE=array

DB_CONNECTION=sqlite

FILESYSTEM_DISK=local

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug
LOG_STACK=single

MAIL_FROM_ADDRESS=hello@example.com
MAIL_FROM_NAME=${APP_NAME}
MAIL_HOST=127.0.0.1
MAIL_MAILER=log
MAIL_PASSWORD=null
MAIL_PORT=2525
MAIL_SCHEME=null
MAIL_USERNAME=null

MEMCACHED_HOST=127.0.0.1

PHP_CLI_SERVER_WORKERS=4

QUEUE_CONNECTION=sync

REDIS_CLIENT=phpredis
REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

SESSION_DOMAIN=null
SESSION_DRIVER=array
SESSION_ENCRYPT=false
SESSION_LIFETIME=120
SESSION_PATH=/

VITE_APP_NAME=${APP_NAME}



## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
