#!/bin/bash

# Substitute environment variables into settings.php
envsubst '${DB_NAME} ${DB_USER} ${DB_PASSWORD} ${DB_HOST} ${DB_PORT}' < /var/www/html/dipas/htdocs/drupal/sites/default/settings.php > /var/www/html/dipas/htdocs/drupal/sites/default/settings.tmp.php

# Move the temporary settings file to the correct location
mv /var/www/html/dipas/htdocs/drupal/sites/default/settings.tmp.php /var/www/html/dipas/htdocs/drupal/sites/default/settings.php

# Ensure the correct ownership and permissions for all project files
chown -R www-data:www-data /var/www/html/dipas/htdocs/drupal \
    && chmod -R 750 /var/www/html/dipas/htdocs/drupal \
    && chmod 444 /var/www/html/dipas/htdocs/drupal/.htaccess \
    && chmod 440 /var/www/html/dipas/htdocs/drupal/sites/default/settings.* \
    && chmod 440 /var/www/html/dipas/config/drupal.services.yml \
    && chmod -R 775 /var/www/html/dipas/htdocs/drupal/sites/default/files \
    
# Execute the main CMD (which starts Apache)
exec "$@"
