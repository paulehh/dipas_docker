FROM php:8.1-apache

# Install necessary libraries, PHP extensions, PostgreSQL client, and tools for handling ZIP files
RUN apt-get update && apt-get install -y \
    libpq-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev postgresql-client unzip rsync gettext-base wget \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo_pgsql \
    && rm -rf /var/lib/apt/lists/*

# Copy and extract project files
RUN wget -O /var/www/html/dipas.zip https://bitbucket.org/geowerkstatt-hamburg/dipas/downloads/dipas-os-3.3.2.zip \
    && unzip /var/www/html/dipas.zip -d /var/www/html/dipas/ \
    && rm -rf /var/www/html/dipas.zip

# Copy configuration files
COPY ./config/drupal/settings.php /var/www/html/dipas/htdocs/drupal/sites/default/settings.php
COPY ./config/drupal/drupal.services.yml /var/www/html/dipas/config/drupal.services.yml

# Copy and set entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Configure Apache and PHP
COPY ./config/apache/yourdomain.de.conf /etc/apache2/sites-available/
RUN a2enmod rewrite && a2dissite 000-default.conf && a2ensite yourdomain.de.conf \
    && echo "memory_limit = 512M" > /usr/local/etc/php/conf.d/memory-limit.ini

# Set entrypoint and default command
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
