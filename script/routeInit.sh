#!/bin/bash

cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

# eth0 -> WAN (Cloud/NAT)
auto eth0
iface eth0 inet dhcp
    post-up sysctl -w net.ipv4.ip_forward=1
    post-up iptables -t nat -C POSTROUTING -o eth0 -j MASQUERADE || iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# eth1 -> SW1 (alpha, beta, gamma)
auto eth1
iface eth1 inet static
    address 192.215.1.1
    netmask 255.255.255.0

# eth2 -> SW2 (delta, epsilon)
auto eth2
iface eth2 inet static
    address 192.215.2.1
    netmask 255.255.255.0

# eth3 -> SW3 (prab, tedd)
auto eth3
iface eth3 inet static
    address 192.215.3.1
    netmask 255.255.255.0

# eth4 -> SW4 (abbey, penny, obladi, desmond, oblada, molly)
auto eth4
iface eth4 inet static
    address 192.215.4.1
    netmask 255.255.255.0
EOF

echo "Konfigurasi /etc/network/interfaces selesai."

# Aktifkan IP forwarding
sysctl -w net.ipv4.ip_forward=1

# Aktifkan NAT keluar melalui eth0
iptables -t nat -C POSTROUTING -o eth0 -j MASQUERADE 2>/dev/null || \
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

echo "IP forwarding dan NAT aktif."

# Restart networking
ifdown eth1 eth2 eth3 eth4 2>/dev/null || true
ifup eth1 eth2 eth3 eth4

echo "Interface LAN sudah diaktifkan."

ip addr
ip route