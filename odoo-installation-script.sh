#!/bin/bash

# Update and Upgrade system
sudo apt update && sudo apt full-upgrade -y

# Install required basic tools
sudo apt install -y build-essential python3-dev python3-venv python3-pip \
    git curl wget libxslt-dev libzip-dev libldap2-dev libsasl2-dev \
    libjpeg-dev libpq-dev gcc g++ libffi-dev libxml2-dev zlib1g-dev \
    libssl-dev libjpeg8-dev liblcms2-dev libblas-dev libatlas-base-dev

# Install PostgreSQL
sudo apt install -y postgresql
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Install Node.js 18 and LESS compiler
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g less less-plugin-clean-css

# Install wkhtmltopdf (for PDF reports)
sudo apt install -y wkhtmltopdf

# Create Odoo directory
mkdir -p ~/odoo
cd ~/odoo

# Clone Odoo 18
git clone https://github.com/odoo/odoo --depth 1 --branch 18.0

# Create Python virtual environment
python3 -m venv ~/odoo/venv
source ~/odoo/venv/bin/activate

# Install Python dependencies
pip install wheel
pip install -r odoo/requirements.txt

# Create PostgreSQL User for Odoo
sudo -u postgres createuser --createdb --username postgres --no-createrole --no-superuser odoo
sudo -u postgres psql -c "ALTER USER odoo WITH PASSWORD 'odoo';"

# Create Odoo configuration file
sudo tee ~/odoo/odoo.conf <<EOL
[options]
admin_passwd = admin
db_host = False
db_port = False
db_user = odoo
db_password = odoo
addons_path = /home/$USER/odoo/odoo/addons,/home/$USER/odoo/custom_addons
; logfile = /var/log/odoo/odoo.log
EOL

# Create custom_addons directory
mkdir -p ~/odoo/custom_addons

# Fix PostgreSQL local authentication method
PG_HBA=$(sudo find /etc/postgresql -name pg_hba.conf)
sudo sed -i 's/peer/md5/' $PG_HBA
sudo systemctl restart postgresql

# Done
echo "Odoo 18 installation finished! To start Odoo, activate venv and run:"
echo "-------------------------------------------------------------"
echo "source ~/odoo/venv/bin/activate"
echo "~/odoo/odoo/odoo-bin -c ~/odoo/odoo.conf"
echo "-------------------------------------------------------------"
