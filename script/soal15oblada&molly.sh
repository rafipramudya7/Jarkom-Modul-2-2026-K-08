#!/bin/bash

# Membuat direktori dan file statis (tanpa PHP)
mkdir -p /var/www/orion
echo "<h1>Ini adalah halaman statis Orion tanpa rendering PHP</h1>" > /var/www/orion/index.html

service nginx restart
