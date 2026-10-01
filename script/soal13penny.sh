nano /etc/apache2/sites-available/000-default.conf

# Blok Redirect 301 (Tugas 13)
<VirtualHost *:80>
    ServerName 192.215.4.2
    ServerAlias penny.ramzy.com
    Redirect permanent / http://www.ramzy.com/
</VirtualHost>

# Blok Utama Proxy (Tugas 11 & 12)
<VirtualHost *:80>
    ServerName ramzy.com
    ServerAlias www.ramzy.com

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
apt-get update
apt-get install apache2 apache2-utils -y
a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests headers alias
htpasswd -cb /etc/apache2/.htpasswd prabs pakar_pinter_jadi_gob***

cat << 'EOF' > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    ServerName 192.215.4.2
    ServerAlias penny.ramzy.com
    Redirect permanent / http://www.ramzy.com/
</VirtualHost>

<VirtualHost *:80>
    ServerName ramzy.com
    ServerAlias www.ramzy.com

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

service apache2 restart
