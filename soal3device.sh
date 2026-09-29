#!/bin/bash

cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.215.X.Y
    netmask 255.255.255.0
    gateway 192.215.X.1
    post-up echo "nameserver 192.168.122.1" > /etc/resolv.conf
EOF

echo "Konfigurasi /etc/network/interfaces:"
cat /etc/network/interfaces

echo ""
echo "Konfigurasi selesai."
echo "Silakan ganti X dan Y sesuai IP perangkat."