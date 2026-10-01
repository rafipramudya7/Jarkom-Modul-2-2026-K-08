#!/bin/bash
set -e

cat >> /etc/bind/named.conf.local << 'EOF'

zone "2.215.192.in-addr.arpa" {
    type slave;
    file "/var/cache/bind/db.192.215.2";
    masters { 192.215.5.2; };
};

zone "4.215.192.in-addr.arpa" {
    type slave;
    file "/var/cache/bind/db.192.215.4";
    masters { 192.215.5.2; };
};

zone "5.215.192.in-addr.arpa" {
    type slave;
    file "/var/cache/bind/db.192.215.5";
    masters { 192.215.5.2; };
};
EOF

named-checkconf
rndc reload

echo "[tedd] soal 8 reverse zones added as slave"