#!/bin/bash

# Check if the admin user exists
if PGPASSWORD="${DB_PASSWORD}" psql -h "${DB_HOST}" -U "${DB_USER}" -d "${DB_NAME}" -c "SELECT 1 FROM users_field_data WHERE name = '${DRUPAL_ADMIN_USER}';" | grep -q "1"; then
    echo "Admin user '${DRUPAL_ADMIN_USER}' exists."
    echo "Skipping Drupal installation."
    # Substitute environment variables into settings.php and drupal.services.yml
    envsubst '${DB_NAME} ${DB_USER} ${DB_PASSWORD} ${DB_HOST} ${DB_PORT} ${DRUPAL_SITE_DOMAIN}' < /var/www/html/dipas/htdocs/drupal/sites/default/settings.php > /var/www/html/dipas/htdocs/drupal/sites/default/settings.tmp.php
    envsubst '${DRUPAL_SITE_DOMAIN}' < /var/www/html/dipas/config/drupal.services.yml > /var/www/html/dipas/config/drupal.services.tmp.yml
    mv /var/www/html/dipas/htdocs/drupal/sites/default/settings.tmp.php /var/www/html/dipas/htdocs/drupal/sites/default/settings.php
    mv /var/www/html/dipas/config/drupal.services.tmp.yml /var/www/html/dipas/config/drupal.services.yml

    # Create temporary directory for Drupal
    mkdir -p /var/www/html/tmp && chown www-data:www-data /var/www/html/tmp && chmod 777 /var/www/html/tmp

    # Set correct file permissions
    chown -R www-data:www-data /var/www/html/dipas/htdocs/drupal \
        && chmod -R 750 /var/www/html/dipas/htdocs/drupal \
        && chmod 444 /var/www/html/dipas/htdocs/drupal/.htaccess \
        && chmod 440 /var/www/html/dipas/htdocs/drupal/sites/default/settings.* \
        && chmod 440 /var/www/html/dipas/config/drupal.services.yml \
        && chmod -R 775 /var/www/html/dipas/htdocs/drupal/sites/default/files \
        && find /var/www/html/dipas/htdocs/drupal/sites/default/files -type f -exec chmod 664 {} \;
    exec "$@"  # Execute the original command
else
    echo "Admin user '${DRUPAL_ADMIN_USER}' does not exist. Proceeding with setup..."
    
    # Proceed with installation steps here

    # Substitute environment variables into settings.php and drupal.services.yml
    envsubst '${DB_NAME} ${DB_USER} ${DB_PASSWORD} ${DB_HOST} ${DB_PORT} ${DRUPAL_SITE_DOMAIN}' < /var/www/html/dipas/htdocs/drupal/sites/default/settings.php > /var/www/html/dipas/htdocs/drupal/sites/default/settings.tmp.php
    envsubst '${DRUPAL_SITE_DOMAIN}' < /var/www/html/dipas/config/drupal.services.yml > /var/www/html/dipas/config/drupal.services.tmp.yml
    mv /var/www/html/dipas/htdocs/drupal/sites/default/settings.tmp.php /var/www/html/dipas/htdocs/drupal/sites/default/settings.php
    mv /var/www/html/dipas/config/drupal.services.tmp.yml /var/www/html/dipas/config/drupal.services.yml

    # Create temporary directory for Drupal
    mkdir -p /var/www/html/tmp && chown www-data:www-data /var/www/html/tmp && chmod 777 /var/www/html/tmp

    # Set correct file permissions
    chown -R www-data:www-data /var/www/html/dipas/htdocs/drupal \
        && chmod -R 750 /var/www/html/dipas/htdocs/drupal \
        && chmod 444 /var/www/html/dipas/htdocs/drupal/.htaccess \
        && chmod 440 /var/www/html/dipas/htdocs/drupal/sites/default/settings.* \
        && chmod 440 /var/www/html/dipas/config/drupal.services.yml \
        && chmod -R 775 /var/www/html/dipas/htdocs/drupal/sites/default/files \
        && find /var/www/html/dipas/htdocs/drupal/sites/default/files -type f -exec chmod 664 {} \;

    # Run Drush installation and other necessary commands
    cd /var/www/html/dipas/htdocs
    ./vendor/bin/drush site-install --db-url=pgsql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME} \
    --account-name=${DRUPAL_ADMIN_USER} --account-pass=${DRUPAL_ADMIN_PASS} \
    --site-name="${DRUPAL_SITE_NAME}" --yes --existing-config

    # Set ignored config entities to avoid issues with imported configurations
    ./vendor/bin/drush config-set config_ignore.settings ignored_config_entities '' -y

    # Import configuration and rebuild caches
    ./vendor/bin/drush config-import -y
    ./vendor/bin/drush cache-rebuild
fi

# Execute the main CMD (start Apache)
exec "$@"
