#!/bin/bash
apt-get update
apt-get install php libapache2-mod-php -y

# Membuat direktori dan file PHP untuk dirender
mkdir -p /var/www/eternal
echo "<?php echo 'Halaman Eternal berhasil dirender dengan PHP!'; ?>" > /var/www/eternal/index.php

service apache2 restart
