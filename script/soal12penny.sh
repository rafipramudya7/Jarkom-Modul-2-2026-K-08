apt-get update
apt-get install apache2-utils -y

htpasswd -cb /etc/apache2/.htpasswd prabs pakar_pinter_jadi_gob***

nano /etc/apache2/sites-available/000-default.conf

<VirtualHost *:80>
    ServerName ramzy.com

    <Proxy balancer://vault>
        BalancerMember http://192.215.5.4
        BalancerMember http://192.215.5.5
    </Proxy>

    ProxyPreserveHost On
    RequestHeader set X-Real-IP expr=%{REMOTE_ADDR}

    ProxyPass / balancer://vault/
    ProxyPassReverse / balancer://vault/

    <Location /admin>
        AuthType Basic
        AuthName "Restricted Area"
        AuthUserFile /etc/apache2/.htpasswd
        Require valid-user
    </Location>
</VirtualHost>

service apache2 restart

#!/bin/bash

# Update dan instalasi paket yang dibutuhkan
apt-get update
apt-get install apache2 apache2-utils -y

# Mengaktifkan modul proxy
a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests headers

# Membuat file kredensial untuk basic authentication
htpasswd -cb /etc/apache2/.htpasswd prabs pakar_pinter_jadi_gob***

# Menulis ulang konfigurasi VirtualHost
cat << 'EOF' > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    ServerName ramzy.com

    <Proxy balancer://vault>
        BalancerMember http://192.215.5.4
        BalancerMember http://192.215.5.5
    </Proxy>

    ProxyPreserveHost On
    RequestHeader set X-Real-IP expr=%{REMOTE_ADDR}

    ProxyPass / balancer://vault/
    ProxyPassReverse / balancer://vault/

    <Location /admin>
        AuthType Basic
        AuthName "Restricted Area"
        AuthUserFile /etc/apache2/.htpasswd
        Require valid-user
    </Location>
</VirtualHost>
EOF

# Restart Apache
service apache2 restart
