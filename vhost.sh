#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'        
ORANGE='\033[0;33m'
NC='\033[0m'

printf "${YELLOW}Site Host:${NC}\n"
read site
printf "${YELLOW}path after /var/www/html/:${NC}\n"
read folder

sudo cp template /etc/apache2/sites-available/$site.conf 
sudo sed -i "s/{{name}}/$site/g" /etc/apache2/sites-available/$site.conf 
sudo sed -i "s+{{folder}}+$folder+g" /etc/apache2/sites-available/$site.conf
sudo a2ensite $site.conf
sudo /etc/init.d/apache2 restart
sudo sh -c "echo '127.0.0.1 $site' >> /etc/hosts"
printf "${GREEN}$site has been created successfuly${NC}\n"
sudo chown www-data:www-data /var/www/html/${folder%/*}/storage -R
sudo chown www-data:www-data /var/www/html/${folder%/*}/bootstrap/cache -R
printf "${GREEN}Permissions for $site has been set successfuly${NC}\n"
