apt-get update
apt-get install nginx -y

nano /etc/nginx/sites-available/default

server {
    listen 80 default_server;
    listen [::]:80 default_server;

    set_real_ip_from 192.215.2.2;
    real_ip_header X-Real-IP;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }
}

service nginx restart




