#!/bin/bash

# Substitute environment variables into settings.php
envsubst '${DB_NAME} ${DB_USER} ${DB_PASSWORD} ${DB_HOST} ${DB_PORT}' < /var/www/html/dipas/htdocs/drupal/sites/default/settings.php > /var/www/html/dipas/htdocs/drupal/sites/default/settings.tmp.php

# Move the temporary settings file to the correct location
mv /var/www/html/dipas/htdocs/drupal/sites/default/settings.tmp.php /var/www/html/dipas/htdocs/drupal/sites/default/settings.php

# Execute the main CMD (which starts Apache)
exec "$@"
