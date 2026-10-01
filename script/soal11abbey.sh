apt-get update
apt-get install nginx -y

nano /etc/nginx/sites-available/default

upstream core {
    server 192.215.5.6;
    server 192.215.5.7;
}

server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://core;
        proxy_set_header X-Real-IP $remote_addr;
    }
}

nginx -t
service nginx restart
