#!/bin/bash
set -e

FAKE_IP="10.99.$((RANDOM % 254 + 1)).$((RANDOM % 254 + 1))"
echo "IP fiktif yang dipakai: $FAKE_IP"

CURRENT_SERIAL=$(grep -oP '\d+(?=\s*;\s*Serial)' /etc/bind/db.ramzy.com)
NEW_SERIAL=$((CURRENT_SERIAL + 1))

sed -i "s/$CURRENT_SERIAL         ; Serial/$NEW_SERIAL         ; Serial/" /etc/bind/db.ramzy.com

sed -i "/^abbey /d" /etc/bind/db.ramzy.com

cat >> /etc/bind/db.ramzy.com << EOF
abbey    15    IN    A    $FAKE_IP
EOF

named-checkzone ramzy.com /etc/bind/db.ramzy.com
rndc reload ramzy.com

echo "[prab] serial naik dari $CURRENT_SERIAL ke $NEW_SERIAL"
echo "[prab] abbey.ramzy.com sekarang -> $FAKE_IP (TTL 15s)"