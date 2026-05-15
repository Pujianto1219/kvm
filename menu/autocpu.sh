#!/bin/bash
# ==========================================
# Script: CPU Overload Auto-Restart & Monitor
# Developer: AcilShop
# ==========================================

colornow=$(cat /etc/rmbl/theme/color.conf 2>/dev/null || echo "cyan")
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/rmbl/theme/$colornow 2>/dev/null | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/rmbl/theme/$colornow 2>/dev/null | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
ipsaya=$(wget -qO- ifconfig.me)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/Pujianto1219/ip/main/ip"

# --- 1. CEK OTORISASI (Dengan Filter Lifetime) ---
checking_sc() {
    useexp=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
    
    if [[ "${useexp,,}" == *"lifetime"* || "$useexp" == *"9999"* ]]; then
        echo -ne
    elif [[ "$date_list" > "$useexp" ]]; then
        echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
        echo -e "$COLOR1 ${NC} ${COLBG1}          ${WH}• AUTOSCRIPT PREMIUM •               ${NC} $COLOR1 $NC"
        echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
        echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
        echo -e "            ${RED}PERMISSION DENIED !${NC}"
        echo -e "   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}"
        echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
        echo -e "             \033[0;33mContact Your Admin ${NC}"
        echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
        
        # Matikan service HANYA jika masa aktif lisensi habis / dibanned
        for svc in nginx kyt xray ws-stunnel dropbear; do
            systemctl stop $svc >/dev/null 2>&1
        done
        exit 1
    fi
}
checking_sc

# --- 2. KALKULASI DURASI & BANDWIDTH (Dengan Filter Lifetime) ---
today=$(date -d "0 days" +"%Y-%m-%d")
Exp2=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')

if [[ "${Exp2,,}" == *"lifetime"* || "$Exp2" == *"9999"* ]]; then
    echo "LIFETIME" > /etc/scdurasi
else
    d1=$(date -d "$Exp2" +%s 2>/dev/null)
    d2=$(date -d "$today" +%s)
    if [[ -n "$d1" ]]; then
        certificate=$(( (d1 - d2) / 86400 ))
        echo "$certificate Hari" > /etc/scdurasi
    else
        echo "0 Hari" > /etc/scdurasi
    fi
fi

vnstat_profile=$(vnstat | sed -n '3p' | awk '{print $1}' | grep -o '[^:]*')
vnstat -i ${vnstat_profile} >/etc/t1
bulan=$(date +%b)
tahun=$(date +%y)
ba=$(curl -sS https://pastebin.com/raw/0gWiX6hE)

if [ "$(grep -wc ${bulan} /etc/t1)" != '0' ]; then
    month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $6}')
    month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $7}')
else
    bulan2=$(date +%Y-%m)
    month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $5}')
    month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $6}')
fi
echo "$month_tx $month_txv" > /etc/usage2

# --- 3. MONITORING STATUS & PENCATATAN ERROR LOG ---
services=("xray" "nginx" "ws-stunnel")
if [[ -e /usr/bin/kyt ]]; then services+=("kyt"); fi

for svc in "${services[@]}"; do
    if ! systemctl is-active --quiet "$svc"; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - [WARNING] Service $svc is DOWN" >> /var/log/vps_monitor.log
    else
        status_log=$(systemctl status "$svc" --no-pager 2>&1)
        if echo "$status_log" | grep -qE "Errno|TERM|error"; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') - [ERROR] Service $svc runs with ERRORS" >> /var/log/vps_monitor.log
        fi
    fi
done

# --- 4. CEK OVERLOAD CPU & AUTO RESTART ---
# Mengambil persentase penggunaan CPU saat ini
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
CPU_INT=${CPU_USAGE%.*}

# Jika CPU di atas 90%, lakukan tindakan drastis (Restart & Deep Clean)
if [ -n "$CPU_INT" ] && [ "$CPU_INT" -gt 90 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - [OVERLOAD] CPU Usage: ${CPU_USAGE}%. Merestart service agar fresh..." >> /var/log/vps_monitor.log
    
    # Pembersihan Cache RAM Tingkat Tinggi (Drop Caches 3)
    sync; echo 3 > /proc/sys/vm/drop_caches
    
    # Restart Service Utama agar beban CPU kembali normal
    systemctl restart xray >/dev/null 2>&1
    systemctl restart nginx >/dev/null 2>&1
    systemctl restart ws-stunnel >/dev/null 2>&1
    systemctl restart dropbear >/dev/null 2>&1
    if [[ -e /usr/bin/kyt ]]; then systemctl restart kyt >/dev/null 2>&1; fi
    
    echo "$(date '+%Y-%m-%d %H:%M:%S') - [INFO] Restart service akibat overload selesai." >> /var/log/vps_monitor.log

else
    # Jika CPU di bawah 90% (Stabil), biarkan service berjalan normal
    # Lakukan pembersihan RAM tingkat rendah saja untuk jaga-jaga
    sync; echo 1 > /proc/sys/vm/drop_caches
fi

# --- 5. CLEAN BASH ZOMBIE ---
bash2=$(pgrep -c bash)
if [[ $bash2 -gt 25 ]]; then
    killall -q bash >/dev/null 2>&1
fi
