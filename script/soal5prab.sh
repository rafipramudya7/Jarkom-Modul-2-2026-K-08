#!/bin/bash
set -e

cat > /etc/bind/db.ramzy.com << 'EOF'
$TTL    604800
@       IN      SOA     prab.ramzy.com. admin.ramzy.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

@       IN      NS      prab.ramzy.com.
@       IN      NS      tedd.ramzy.com.

prab    IN      A       192.215.5.2
tedd    IN      A       192.215.5.3

@       IN      A       192.215.4.2

alpha    IN      A       192.215.1.2
beta     IN      A       192.215.1.3
gamma    IN      A       192.215.1.4
delta    IN      A       192.215.3.2
epsilon  IN      A       192.215.3.3
abbey    IN      A       192.215.2.2
penny    IN      A       192.215.4.2
obladi   IN      A       192.215.5.4
desmond  IN      A       192.215.5.5
oblada   IN      A       192.215.5.6
molly    IN      A       192.215.5.7
EOF

chown bind:bind /etc/bind/db.ramzy.com
named-checkzone ramzy.com /etc/bind/db.ramzy.com
rndc reload ramzy.com

echo "[prab] soal 5 zona updated, serial=2"