apt-get update
apt-get install apache2 -y

nano /etc/apache2/apache2.conf

LogFormat "%{X-Real-IP}i %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" combined

service apache2 restart
