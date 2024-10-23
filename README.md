
# DIPAS Docker

This project provides a Docker setup for the DIPAS (Digital Participation System).

## Steps to Get Started

### Step 1: Clone the Repository
Clone the repository to your host machine:

```bash
git clone <repository-url>
```

### Step 2: Customize Configuration Files
- Edit the `.env` file to suit your environment.
- Customize the `./config/yourdomain.de.conf` file with the settings for your domain.

### Step 3: Download the Latest DIPAS Community Version
Download the latest version of the **DIPAS Community** as a ZIP file from the [official Bitbucket repository](https://bitbucket.org/geowerkstatt-hamburg/dipas_community/downloads/).

Place the downloaded ZIP file in the `dipas_community_version` folder on your host.

### Step 4: Build and Run the Docker Containers
Run the following command to build the Docker containers and start the services:

```bash
docker-compose up --build
```

### Step 5: Wait for the Installation to Complete
The installation process, configuration import, and cache rebuild will take some time. Please wait until it's complete.

### Step 6: Access the DIPAS Application
Once the installation is complete, you can log in to the DIPAS system at:

```
http://yourhost.de/drupal
```
