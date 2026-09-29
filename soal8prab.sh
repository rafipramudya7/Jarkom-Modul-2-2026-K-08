#!/bin/bash
set -e

cat >> /etc/bind/named.conf.local << 'EOF'

zone "2.215.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.215.2";
    allow-transfer { 192.215.5.3; };
};

zone "4.215.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.215.4";
    allow-transfer { 192.215.5.3; };
};

zone "5.215.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.215.5";
    allow-transfer { 192.215.5.3; };
};
EOF

cat > /etc/bind/db.192.215.2 << 'EOF'
$TTL    604800
@       IN      SOA     prab.ramzy.com. admin.ramzy.com. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

@       IN      NS      prab.ramzy.com.
@       IN      NS      tedd.ramzy.com.

2       IN      PTR     abbey.ramzy.com.
EOF

cat > /etc/bind/db.192.215.4 << 'EOF'
$TTL    604800
@       IN      SOA     prab.ramzy.com. admin.ramzy.com. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

@       IN      NS      prab.ramzy.com.
@       IN      NS      tedd.ramzy.com.

2       IN      PTR     penny.ramzy.com.
EOF

cat > /etc/bind/db.192.215.5 << 'EOF'
$TTL    604800
@       IN      SOA     prab.ramzy.com. admin.ramzy.com. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

@       IN      NS      prab.ramzy.com.
@       IN      NS      tedd.ramzy.com.

2       IN      PTR     prab.ramzy.com.
3       IN      PTR     tedd.ramzy.com.
4       IN      PTR     obladi.ramzy.com.
5       IN      PTR     desmond.ramzy.com.
6       IN      PTR     oblada.ramzy.com.
7       IN      PTR     molly.ramzy.com.
EOF

chown bind:bind /etc/bind/db.192.215.2 /etc/bind/db.192.215.4 /etc/bind/db.192.215.5

named-checkconf
named-checkzone 2.215.192.in-addr.arpa /etc/bind/db.192.215.2
named-checkzone 4.215.192.in-addr.arpa /etc/bind/db.192.215.4
named-checkzone 5.215.192.in-addr.arpa /etc/bind/db.192.215.5

rndc reload

echo "[prab] soal 8 reverse zones added"