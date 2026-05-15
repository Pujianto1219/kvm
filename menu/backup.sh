#!/bin/bash
# ==========================================
# Script: Backup Data VPS to Cloud (Rclone)
# Developer: AcilShop
# ==========================================

# Warna
export NC="\e[0m"
export RED="\033[0;31m"
export GREEN="\033[0;32m"
export YELLOW="\033[0;33m"
export BLUE="\033[0;34m"
export CYAN="\033[0;36m"
export WH="\033[1;37m"

# Ambil Tema Warna
colornow=$(cat /etc/rmbl/theme/color.conf 2>/dev/null || echo "cyan")
export COLOR1="$(cat /etc/rmbl/theme/$colornow 2>/dev/null | grep -w "TEXT" | cut -d: -f2 | sed 's/ //g')"
export COLBG1="$(cat /etc/rmbl/theme/$colornow 2>/dev/null | grep -w "BG" | cut -d: -f2 | sed 's/ //g')"

# Pengecekan Otorisasi
ipsaya=$(curl -s -4 icanhazip.com)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/Pujianto1219/ip/main/ip"

checking_sc() {
    useexp=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
    if [[ "$date_list" < "$useexp" ]]; then
        echo -ne
    else
        systemctl stop nginx >/dev/null 2>&1
        clear
        echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
        echo -e "$COLOR1│${NC}${COLBG1}          ${WH}• AUTOSCRIPT PREMIUM •                 ${NC}$COLOR1│"
        echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
        echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
        echo -e "$COLOR1│            ${RED}PERMISSION DENIED !${NC}                  $COLOR1│"
        echo -e "$COLOR1│   ${YELLOW}Your VPS${NC} $ipsaya ${CYAN}Has been Banned${NC}      $COLOR1│"
        echo -e "$COLOR1│      ${YELLOW}Buy access permissions for scripts${NC}          $COLOR1│"
        echo -e "$COLOR1│               ${GREEN}Contact Your Admin ${NC}                  $COLOR1│"
        echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
        exit 1
    fi
}
checking_sc

clear
IP=$(wget -qO- ipv4.icanhazip.com)
date=$(date +"%Y-%m-%d")

echo -e "[ ${GREEN}INFO${NC} ] Mohon Menunggu, Proses Backup sedang berlangsung..."

# Penyiapan Direktori Backup
rm -rf /root/backup
mkdir -p /root/backup

# Pengumpulan Data Backup
cp -rf /etc/passwd /root/backup/ &> /dev/null
cp -rf /etc/group /root/backup/ &> /dev/null
cp -rf /etc/shadow /root/backup/ &> /dev/null
cp -rf /etc/gshadow /root/backup/ &> /dev/null
cp -rf /usr/bin/idchat /root/backup/ &> /dev/null
cp -rf /usr/bin/token /root/backup/ &> /dev/null
cp -rf /etc/per/id /root/backup/ &> /dev/null
cp -rf /etc/per/token /root/backup/token2 &> /dev/null
cp -rf /etc/perlogin/id /root/backup/loginid &> /dev/null
cp -rf /etc/perlogin/token /root/backup/logintoken &> /dev/null
cp -rf /etc/xray/config.json /root/backup/xray &> /dev/null
cp -rf /etc/xray/ssh /root/backup/ssh &> /dev/null
cp -rf /home/vps/public_html /root/backup/public_html &> /dev/null
cp -rf /etc/xray/sshx /root/backup/sshx &> /dev/null
cp -rf /etc/xray/noob /root/backup/noob &> /dev/null
cp -rf /etc/vmess /root/backup/vmess &> /dev/null
cp -rf /etc/vless /root/backup/vless &> /dev/null
cp -rf /etc/trojan /root/backup/trojan &> /dev/null
cp -rf /etc/trojan-go /root/backup/trojan-go &> /dev/null
cp -rf /etc/issue.net /root/backup/issue &> /dev/null

# Zipping Data
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1

# Upload ke Cloud Storage via Rclone
echo -e "[ ${GREEN}INFO${NC} ] Mengunggah ke Cloud Storage..."
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)

# Ekstraksi ID Link GDrive (Disesuaikan agar lebih akurat)
id=$(echo "$url" | grep -oP '(?<=/d/)[a-zA-Z0-9_-]+' || echo "$url" | grep -oP '(?<=id=)[a-zA-Z0-9_-]+')

if [[ -n "$id" ]]; then
    link="https://drive.google.com/u/0/uc?id=${id}&export=download"
else
    link="$url" # Fallback jika rclone tidak mengembalikan format GDrive standar
fi

# Pembersihan File Sementara
rm -rf /root/backup
rm -f /root/$IP-$date.zip

clear
# Menampilkan Hasil dengan Kotak yang Kompak dan Presisi
echo -e "${CYAN}┌─────────────────────────────────────────────┐${NC}"
echo -e "${CYAN}│${NC} ${WH}INFORMASI DETAIL BACKUP DATA${NC}                ${CYAN}│${NC}"
echo -e "${CYAN}├─────────────────────────────────────────────┤${NC}"
echo -e "${CYAN}│${NC} IP VPS  : ${WH}$IP${NC}"
echo -e "${CYAN}│${NC} Tanggal : ${WH}$date${NC}"
echo -e "${CYAN}│${NC} Link    : ${GREEN}$link${NC}"
echo -e "${CYAN}└─────────────────────────────────────────────┘${NC}"
echo -e " Silakan salin link di atas untuk keperluan restore."
echo ""
read -n 1 -s -r -p " Tekan tombol apa saja untuk kembali ke menu..."
menu
