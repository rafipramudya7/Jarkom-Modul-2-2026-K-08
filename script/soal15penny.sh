#!/bin/bash

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

    # Jalur proxy khusus untuk /eternal
    ProxyPass /eternal balancer://vault/eternal
    ProxyPassReverse /eternal balancer://vault/eternal

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
