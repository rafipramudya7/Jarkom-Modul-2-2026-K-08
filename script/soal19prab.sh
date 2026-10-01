nano /etc/bind/db.ramzy

outbound IN  CNAME  http.badssl.com.

service bind9 restart

#!/bin/bash

# Menambahkan CNAME record ke dalam file zone DNS ramzy.com
cat << 'EOF' >> /etc/bind/db.ramzy

; [Tugas 19] CNAME Record untuk domain eksternal
outbound IN  CNAME http.badssl.com.
EOF

# Restart layanan DNS
service bind9 restart
