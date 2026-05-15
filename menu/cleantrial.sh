#!/bin/bash
# ==========================================
# Script: Khusus Pembersih File Teks Trial
# ==========================================

# 1. Menghapus semua file berawalan atau mengandung kata "trial" di direktori /root
rm -f /root/trial* >/dev/null 2>&1
rm -f /root/*trial*.txt >/dev/null 2>&1

# 2. Menghapus semua file trial di direktori public_html (jika Anda pakai fitur link web)
if [ -d "/home/vps/public_html" ]; then
    rm -f /home/vps/public_html/trial* >/dev/null 2>&1
    rm -f /home/vps/public_html/*trial*.txt >/dev/null 2>&1
fi

# 3. Menghapus sisa-sisa file akun trial yang terlanjur terbuat (Opsional untuk kerapian)
rm -f /root/Akun-Trial* >/dev/null 2>&1

# 4. Clear cache RAM ringan agar sistem tetap fresh
sync; echo 1 > /proc/sys/vm/drop_caches

exit 0
