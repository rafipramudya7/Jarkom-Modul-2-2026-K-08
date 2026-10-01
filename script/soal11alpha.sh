tail -f /var/log/nginx/access.log

tail -f /var/log/apache2/access.log

curl http://192.215.2.2  # Uji Load Balancer Abbey
curl http://192.215.4.2  # Uji Load Balancer Penny
