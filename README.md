# Odoo 18 Installation Script for Linux (WSL)

This script automates the installation of Odoo 18 on a Linux-based system (such as WSL). It handles the installation of required dependencies, PostgreSQL, Node.js, wkhtmltopdf, and Odoo itself. Additionally, it configures PostgreSQL, creates necessary users, and sets up the Odoo configuration file.


## Features

- Updates and upgrades the system packages.
- Installs all necessary dependencies for Odoo 18.
- Sets up PostgreSQL and creates a `odoo` user specifically for Odoo.
- Installs Node.js and LESS compiler for frontend assets.
- Installs wkhtmltopdf for PDF reports.
- Configures the Odoo instance with a custom configuration file.
- Creates a Python virtual environment for Odoo.

## Installation

### Step 1: Clone the repository

Clone this repository to your machine:
```bash
git clone https://github.com/ReaperPsych/odoo-installation-script.git
cd odoo-installation-script
```

### Step 2: Make the file executible
```bash
sudo chmod +x odoo-installation-script.sh
```

### Step 3: Run the file
```bash
./odoo-installation-script.sh
```

### Step 4: Activate virtual environment
```bash
cd ~/odoo
source venv/bin/activate
```

### Step 5: Run the odoo instance
```bash
~/odoo/odoo/odoo-bin -c ~/odoo/odoo.conf
```

> **Note:**  
> The PostgreSQL user for Odoo, as well as the `db_user` and `db_password` in the Odoo configuration file, are set to `odoo` by default.
