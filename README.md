
# DIPAS Docker

This project provides a Test Docker setup for the DIPAS (Digital Participation System: https://bitbucket.org/geowerkstatt-hamburg/dipas/src). This project was created for initial setup and installation of DIPAS e.g. to deploy it on a testserver. 

## Steps to Get Started

Make sure that you have docker and docker-compose installed 

### Step 1: Clone the Repository
Clone the repository to your host machine:

```bash
git clone https://github.com/matlendzi/dipas_docker.git
```

### Step 2: Customize Configuration Files
- Edit the `.env` file to suit your environment (at least by specifying your domain as DRUPAL_SITE_DOMAIN)
- Customize the `./config/apache/yourdomain.de.conf` by specfiying your domain as servername and alias.
- OPTIONAL: Customize the `./config/drupal/drupal.services.yml` and `./config/drupal/settings.php` file to your needs 

### Step 3: Build and Run the Docker Containers
Run the following command to build the Docker containers and start the services:

```bash
docker-compose up --build
```
### Step 5: Wait for the Installation to Complete
The installation process, translation import, and cache rebuild will take some time. Please wait until it's complete.

### Step 6: Access the DIPAS Application
Once the installation is complete, you can log in to the DIPAS system at:
```
http://yourhost.de/drupal
```
### Step 7: Create DIPAS Template Proceeding (default)
Go to --> DIPAS --> Verfahren --> Verfahren and "Verfahren hinzufügen". In the Interface click on "speichern". The default proceeding is your template from which all new proceedings will be build up.

### Step 8: Administer DIPAS Template Proceeding
Follow these steps: https://wiki.dipas.org/index.php/Verfahrensvorlage_erstellen#Technische_Vorarbeiten
Note: You do not need to import translation files since it was automatically done by drush during the setup process.

### Step 8: Create DIPAS Test Proceeding
Go to --> DIPAS --> Verfahren --> Verfahren and "Verfahren hinzufügen". In the Interface type hostname e.g "test" (this will be the subdomain of your new proceeding) and name of your proceeding, e.g. "test". click "speichern".

### Step 9: Access your Test Proceeding
go to test.yourdomain.de/drupal and finalize the configuration of your proceeding or go to test.yourdomain.de to see the frontend.


