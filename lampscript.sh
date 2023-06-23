#This script allows us to stand up a LAMP STACK In a DEBIAN based environment. 
#This moves us to an appropriate beginning state of the script
sudo apt update -y && sudo apt upgrade -y
#This section defines the functions and variables used below we do not include the environment variables
#like $USER in this section. 
APPHOME="/var/www/html"
#This section will run a function that installs the dependencies for this setup
set -e
function dep () {
sudo apt install curl -y
sudo apt install apache2 libapache2-mod-security2 -y
sudo apt install mariadb-server -y
sudo apt install php php-pdo php-mysql -y
}
#This section below create the firewall rules necessary for lamp to function
function firewallConf () {
sudo ufw allow 22
sudo ufw enable
sudo ufw allow 80
sudo ufw allow 443
}
dep
sudo chown -R $USER:$USER $APPHOME
firewallConf
sudo mysql_secure_installation
sudo systemctl enable mariadb.service
sudo systemctl restart mariadb.service
sudo echo -e "<html>\n<head>\n<title>My Hello World Page</title>\n</head>\n<body><p> Hello World!</p>\n<p> My name is $USER and this is my first web page</p>\n</body>\n</html>" > $APPHOME/landing.html
sudo echo "<?php phpinfo(); ?>" > $APPHOME/phptest.php
