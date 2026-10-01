#!/bin/bash
# Memastikan repositori lokal up to date
apt-get update

# Menginstal ApacheBench (ab)
apt-get install apache2-utils -y

ab -n 250 -c 10 http://www.ramzy.com/

ab -n 250 -c 10 http://static.ramzy.com/
