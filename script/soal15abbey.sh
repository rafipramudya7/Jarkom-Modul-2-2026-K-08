#!/bin/bash

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

    # Jalur proxy khusus untuk /orion
    location /orion/ {
        proxy_pass http://core/orion/;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location / {
        proxy_pass http://core;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
EOF

nginx -t
service nginx restart
