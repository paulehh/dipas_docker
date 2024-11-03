# 🌐 DIPAS Docker Setup

Welcome to the **DIPAS Docker Project**! This repository provides a test Docker setup for [DIPAS (Digital Participation System)](https://bitbucket.org/geowerkstatt-hamburg/dipas/src). This setup is ideal for getting started with DIPAS installation and deployment on a test server. 

Here you can find also a short video showing the process:

[![YouTube](http://i.ytimg.com/vi/TCiz3GqFRjM/hqdefault.jpg)](https://www.youtube.com/watch?v=TCiz3GqFRjM)

## 🚀 Quick Start Guide

> **Prerequisites:** Make sure Docker and Docker Compose are installed on your system.

### 📂 Step 1: Clone the Repository
Clone this repository to your host machine:
```bash
git clone https://github.com/matlendzi/dipas_docker.git
```

### ⚙️ Step 2: Customize Configuration Files
1. **Edit the `.env` file:**  
   Update the file with your specific environment variables (e.g., set `DRUPAL_SITE_DOMAIN` with your domain).
   
2. **Edit Apache Configuration:**  
   Update `./config/apache/yourdomain.de.conf` to set your domain as the `ServerName` and `ServerAlias`.
   
3. *(Optional)* **Additional Customizations:**  
   You may customize `./config/drupal/drupal.services.yml` and `./config/drupal/settings.php` to meet your needs.

### 🛠️ Step 3: Build and Start Docker Containers
Build the Docker images and start the containers with:
```bash
docker-compose up --build
```

### ⏳ Step 4: Installation in Progress
The setup process will include installation, translation import, and cache rebuilding. This may take a few minutes—please wait until it completes.

### 🌐 Step 5: Access the DIPAS Application
Once installation finishes, access DIPAS at:
```
http://yourhost.de/drupal
```

### 📝 Step 6: Create DIPAS Template Proceeding
To create a template proceeding:
- Navigate to **DIPAS > Verfahren > Verfahren**.
- Click on **Verfahren hinzufügen**, then **Speichern**.  
  This default proceeding will serve as the template for all new proceedings.

### ⚙️ Step 7: Administer the Template Proceeding
Follow [these steps](https://wiki.dipas.org/index.php/Verfahrensvorlage_erstellen#Technische_Vorarbeiten) for additional configurations.  
*Note:* Translation files have already been imported automatically during the setup.

### 🧪 Step 8: Create a DIPAS Test Proceeding
To set up a test proceeding:
- Go to **DIPAS > Verfahren > Verfahren** and click **Verfahren hinzufügen**.
- Set the hostname (e.g., "test" for `test.yourdomain.de`) and provide a name for the proceeding.
- Click **Speichern**.

### 🌍 Step 9: Access Your Test Proceeding
Access your test proceeding at `http://test.yourdomain.de/drupal`.  
From here, you can finalize any additional configurations for your proceeding, or visit `http://test.yourdomain.de` to view the frontend.
