#!/bin/bash
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

# --- 1. CEK OTORISASI ---
checking_sc() {
    useexp=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
    if [[ "$date_list" > "$useexp" ]]; then
        echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
        echo -e "$COLOR1 ${NC} ${COLBG1}          ${WH}• AUTOSCRIPT PREMIUM •               ${NC} $COLOR1 $NC"
        echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
        echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
        echo -e "            ${RED}PERMISSION DENIED !${NC}"
        echo -e "   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}"
        echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
        echo -e "             \033[0;33mContact Your Admin ${NC}"
        echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
        
        # Matikan service jika masa aktif habis
        for svc in nginx kyt xray ws-stunnel; do
            systemctl stop $svc >/dev/null 2>&1
        done
        exit 1
    fi
}
checking_sc

# --- 2. CEK PORT SSH/DROPBEAR (Aman dari Reboot Loop) ---
# Alih-alih nmap dari luar, kita cek apakah service ssh lokal berjalan
if ! systemctl is-active --quiet ssh && ! systemctl is-active --quiet sshd; then
    systemctl restart ssh >/dev/null 2>&1
    systemctl restart sshd >/dev/null 2>&1
fi

# --- 3. KALKULASI DURASI & BANDWIDTH ---
today=$(date -d "0 days" +"%Y-%m-%d")
Exp2=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
d1=$(date -d "$Exp2" +%s)
d2=$(date -d "$today" +%s)
certificate=$(( (d1 - d2) / 86400 ))
echo "$certificate Hari" > /etc/scdurasi

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

# --- 4. AUTO HEALING SERVICES (Lebih Cepat & Ringan) ---
# Daftar service yang harus dipantau
services=("xray" "nginx" "ws-stunnel")

# Tambahkan kyt jika file bin-nya ada
if [[ -e /usr/bin/kyt ]]; then
    services+=("kyt")
fi

for svc in "${services[@]}"; do
    # Jika service tidak aktif, langsung restart
    if ! systemctl is-active --quiet "$svc"; then
        systemctl restart "$svc"
    else
        # Pengecekan error spesifik tambahan dari status
        status_log=$(systemctl status "$svc" --no-pager 2>&1)
        if echo "$status_log" | grep -qE "Errno|TERM|error"; then
            systemctl restart "$svc"
        fi
    fi
done

# --- 5. CLEAN BASH ZOMBIE ---
bash2=$(pgrep -c bash)
if [[ $bash2 -gt 25 ]]; then
    killall -q bash
fi
