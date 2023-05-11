#This moves us to an appropriate beginning state of the script
sudo apt update -y && sudo apt upgrade -y
#This section defines the functions and variables used below we do not include the environment variables
#like $USER in this section. 
apache2home="/var/www/html"
#This section will run a function that installs the dependencies for this setup
set -e
function dep () {
sudo apt install curl -y
sudo apt install apache2 -y
sudo apt install mariadb-server -y
sudo apt install php php-pdo php8.1-mysql -y
}
#This section below create the firewall rules necessary for lamp to function
function firewallConf () {
sudo ufw allow 22
sudo ufw enable
sudo ufw allow 80
sudo ufw allow 443
}
dep
sudo chown $USER:$USER $apache2home
firewallConf
sudo mysql_secure_installation
sudo systemctl enable mariadb.service
sudo systemctl restart mariadb.service
sudo echo -e "<html>\n<head>\n<title>My Hello World Page</title>\n</head>\n<body><p> Hello World!</p>\n<p> My name is $USER and this is my first web page</p>\n</body>\n</html>" > $apache2home/landing.html
sudo echo "<?php phpinfo(); ?>" > $apache2home/phptest.php
