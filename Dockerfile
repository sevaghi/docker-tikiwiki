FROM php:8.4-apache

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libicu-dev \
    zlib1g-dev \
    unzip \
    git \
    curl \
    mariadb-client \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        mysqli \
        mbstring \
        gd \
        xml \
        zip \
        intl \
        opcache \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite headers

COPY config/php.ini /usr/local/etc/php/
COPY apache/tiki.conf /etc/apache2/sites-available/000-default.config

WORKDIR /var/www/html

RUN curl -L https://sourceforge.net/projects/tikiwiki/files/Tiki_27.x_Miaplacidus/27.2/tiki-27.2.zip/download -o tiki.zip \
    && unzip tiki.zip -d /var/www/html \
    && rm tiki.zip \
    && mv /var/www/html/tiki-27.2/* /var/www/html/ \
    && rm -rf /var/www/html/tiki-27.2

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
