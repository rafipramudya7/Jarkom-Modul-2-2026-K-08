apt-get update
apt-get install apache2 -y
a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests headers

nano /etc/apache2/sites-available/000-default.conf

<VirtualHost *:80>
    <Proxy balancer://vault>
        BalancerMember http://192.215.5.4
        BalancerMember http://192.215.5.5
    </Proxy>

    ProxyPreserveHost On
    RequestHeader set X-Real-IP expr=%{REMOTE_ADDR}

    ProxyPass / balancer://vault/
    ProxyPassReverse / balancer://vault/
</VirtualHost>

service apache2 restart
