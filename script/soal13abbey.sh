nano /etc/nginx/sites-available/default

upstream core {
    server 192.215.5.6;
    server 192.215.5.7;
}

# Blok Redirect 302 (Tugas 13)
server {
    listen 80;
    server_name 192.215.2.2 abbey.ramzy.com;
    return 302 http://static.ramzy.com$request_uri;
}

# Blok Utama Proxy (Tugas 11)
server {
    listen 80;
    server_name static.ramzy.com ramzy.com _;

    location / {
        proxy_pass http://core;
        proxy_set_header X-Real-IP $remote_addr;
    }
}

nginx -t

service nginx restart

#!/bin/bash
apt-get update
apt-get install nginx -y

cat << 'EOF' > /etc/nginx/sites-available/default
upstream core {
    server 192.215.5.6;
    server 192.215.5.7;
}

server {
    listen 80;
    server_name 192.215.2.2 abbey.ramzy.com;
    return 302 http://static.ramzy.com$request_uri;
}

server {
    listen 80;
    server_name static.ramzy.com ramzy.com _;

    location / {
        proxy_pass http://core;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
EOF

service nginx restart
