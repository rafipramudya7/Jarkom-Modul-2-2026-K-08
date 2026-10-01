# 1. Matikan (Stop) salah satu node, misalnya Abbey, langsung dari interface GNS3.
# 2. Nyalakan kembali (Start) node tersebut.
# 3. Buka console Abbey. Tunggu beberapa saat karena proses instalasi paket (apt-get) dari script Anda sedang berjalan otomatis di latar belakang.

service nginx status

# service apache2 status jika Anda mengetesnya di node Penny, atau service bind9 status jika di node Prab
