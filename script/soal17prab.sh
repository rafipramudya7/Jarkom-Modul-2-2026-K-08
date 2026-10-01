nano /etc/bind/db.ramzy

alpha   IN  TXT "alpha"
beta    IN  TXT "beta"
gamma   IN  TXT "gamma"
delta   IN  TXT "delta"
epsilon IN  TXT "epsilon"

service bind9 restart

#!/bin/bash

# Menambahkan TXT record ke dalam file zone DNS ramzy.com
# Pastikan nama file /etc/bind/db.ramzy sesuai dengan nama file zone yang Anda gunakan
cat << 'EOF' >> /etc/bind/db.ramzy

; [Tugas 17] TXT Record untuk klien sayap kiri dan kanan
alpha   IN  TXT "alpha"
beta    IN  TXT "beta"
gamma   IN  TXT "gamma"
delta   IN  TXT "delta"
epsilon IN  TXT "epsilon"
EOF

# Restart layanan DNS
service bind9 restart
