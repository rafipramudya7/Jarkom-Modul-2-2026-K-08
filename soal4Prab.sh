#!/bin/bash
set -e

apt-get install -y bind9 bind9utils dnsutils >/dev/null

cat > /etc/bind/named.conf.options << 'EOF'
options {
    directory "/var/cache/bind";
    forwarders {
        192.168.122.1;
    };
};
EOF

cat > /etc/bind/named.conf.local << 'EOF'
zone "ramzy.com" {
    type master;
    file "/etc/bind/db.ramzy.com";
    notify yes;
    allow-transfer { 192.215.5.3; };
};
EOF

cat > /etc/bind/db.ramzy.com << 'EOF'
$TTL    604800
@       IN      SOA     prab.ramzy.com. admin.ramzy.com. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

@       IN      NS      prab.ramzy.com.
@       IN      NS      tedd.ramzy.com.

prab    IN      A       192.215.5.2
tedd    IN      A       192.215.5.3

@       IN      A       192.215.4.2
EOF

mkdir -p /run/named
chown bind:bind /run/named
chown -R bind:bind /var/cache/bind
chown bind:bind /etc/bind/db.ramzy.com

named-checkconf
named-checkzone ramzy.com /etc/bind/db.ramzy.com

pkill named 2>/dev/null || true
sleep 1
named -u bind -c /etc/bind/named.conf

echo "nameserver 127.0.0.1" > /etc/resolv.conf
echo "[prab] setup done"