#!/bin/bash
# ==========================================
# Script: Auto CPU & RAM Cleaner
# Developer: AcilShop
# ==========================================

# Threshold CPU (Batas penggunaan dalam persen)
CPU_LIMIT=90

# Ambil penggunaan CPU saat ini
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
CPU_INT=${CPU_USAGE%.*}

# Jika penggunaan CPU melebihi batas
if [ "$CPU_INT" -gt "$CPU_LIMIT" ]; then
    # Catat ke log
    echo "$(date): High CPU detected ($CPU_USAGE%). Cleaning caches..." >> /var/log/autocpu.log
    
    # Bersihkan Cache RAM (Drop Caches)
    sync; echo 3 > /proc/sys/vm/drop_caches
    
    # Opsional: Restart service berat jika diperlukan
    systemctl restart xray > /dev/null 2>&1
    systemctl restart ws-stunnel > /dev/null 2>&1
fi

# Pembersihan RAM rutin setiap kali script jalan
sync; echo 1 > /proc/sys/vm/drop_caches
