#!/bin/bash

# Inisialisasi variabel
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")
colornow=$(cat /etc/rmbl/theme/color.conf 2>/dev/null || echo "default")
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/rmbl/theme/$colornow 2>/dev/null | grep -w "TEXT" | cut -d: -f2 | sed 's/ //g' || echo '\033[0;96m')"
COLBG1="$(cat /etc/rmbl/theme/$colornow 2>/dev/null | grep -w "BG" | cut -d: -f2 | sed 's/ //g' || echo '\033[40m')"
WH='\033[1;37m'

# Mendapatkan IP server
ipsaya=$(curl -sS ipv4.icanhazip.com 2>/dev/null || curl -sS ifconfig.me 2>/dev/null)
ipaya=$(wget -qO- ifconfig.me 2>/dev/null)

# Mendapatkan data server
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //' || date)
date_list=$(date +"%Y-%m-%d" -d "$data_server" 2>/dev/null || date +"%Y-%m-%d")

# URL data IP
data_ip="https://raw.githubusercontent.com/Pujianto1219/ip/main/ip"

# Fungsi pengecekan script
checking_sc() {
    if [[ -z "$ipsaya" ]]; then
        echo -e "${RED}Error: Tidak dapat mendapatkan IP server${NC}"
        exit 1
    fi
    
    useexp=$(curl -sS "$data_ip" 2>/dev/null | grep "$ipsaya" | awk '{print $3}')
    
    if [[ -z "$useexp" ]]; then
        echo -e "${RED}Error: IP tidak ditemukan dalam database${NC}"
        exit 1
    fi
    
    if [[ "$date_list" < "$useexp" ]]; then
        echo -ne
    else
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│${NC} ${COLBG1}         ${WH}• AUTOSCRIPT PREMIUM •                ${NC} $COLOR1│ $NC"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│            ${COLOR1}PERMISSION DENIED !${NC}                  │"
        echo -e "$COLOR1│   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}                             │"
        echo -e "$COLOR1│     \033[0;33mBuy access permissions for scripts${NC}          │"
        echo -e "$COLOR1│             \033[0;33mContact Your Admin ${NC}                 │"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        exit 1
    fi
}

# Jalankan pengecekan
checking_sc
clear

# Inisialisasi variabel sistem
cd
ISP=$(cat /etc/xray/isp 2>/dev/null || echo "Unknown ISP")
CITY=$(cat /etc/xray/city 2>/dev/null || echo "Unknown City")
author=$(cat /etc/profil 2>/dev/null || echo "Unknown Author")
TIMES="10"
CHATID=$(cat /etc/per/id 2>/dev/null)
KEY=$(cat /etc/per/token 2>/dev/null)
URL="https://api.telegram.org/bot$KEY/sendMessage"
domain=$(cat /etc/xray/domain 2>/dev/null || echo "example.com")
CHATID2=$(cat /etc/perlogin/id 2>/dev/null)
KEY2=$(cat /etc/perlogin/token 2>/dev/null)
URL2="https://api.telegram.org/bot$KEY2/sendMessage"

# Buat direktori jika belum ada
[[ ! -e /etc/vmess/akun ]] && mkdir -p /etc/vmess/akun
[[ ! -e /etc/limit/vmess ]] && mkdir -p /etc/limit/vmess

# Fungsi untuk mengecek dan memperbaiki konfigurasi logging Xray
fix_xray_logging() {
    echo "Memeriksa konfigurasi logging Xray..."
    
    # Backup konfigurasi
    cp /etc/xray/config.json /etc/xray/config.json.backup 2>/dev/null
    
    # Pastikan direktori log ada
    mkdir -p /var/log/xray
    chown nobody:nogroup /var/log/xray 2>/dev/null
    
    # Periksa apakah logging sudah dikonfigurasi
    if ! grep -q '"log"' /etc/xray/config.json 2>/dev/null; then
        echo "Menambahkan konfigurasi logging ke Xray..."
        
        # Backup original config
        cp /etc/xray/config.json /etc/xray/config.json.orig
        
        # Tambahkan konfigurasi log menggunakan sed
        sed -i '1s/^{/{/' /etc/xray/config.json
        sed -i '1a\  "log": {\n    "access": "/var/log/xray/access.log",\n    "error": "/var/log/xray/error.log",\n    "loglevel": "info"\n  },' /etc/xray/config.json
        
        # Restart Xray
        systemctl restart xray
        sleep 3
        echo "Konfigurasi logging berhasil ditambahkan."
    fi
    
    # Pastikan file log ada dan dapat ditulis
    touch /var/log/xray/access.log /var/log/xray/error.log
    chown nobody:nogroup /var/log/xray/*.log 2>/dev/null
    chmod 644 /var/log/xray/*.log
}

# Fungsi convert yang diperbaiki
function convert() {
    local -i bytes=$1
    if [[ $bytes -lt 1024 ]]; then
        echo "${bytes} B"
    elif [[ $bytes -lt 1048576 ]]; then
        echo "$(((bytes + 1023) / 1024)) KB"
    elif [[ $bytes -lt 1073741824 ]]; then
        echo "$(((bytes + 1048575) / 1048576)) MB"
    else
        echo "$(((bytes + 1073741823) / 1073741824)) GB"
    fi
}

# Fungsi tim2sec yang diperbaiki
tim2sec() {
    local mult=1
    local arg="$1"
    local inu=0
    
    while [[ ${#arg} -gt 0 ]]; do
        local prev="${arg%:*}"
        if [[ "$prev" = "$arg" ]]; then
            local curr="${arg#0}"
            prev=""
        else
            local curr="${arg##*:}"
            curr="${curr#0}"
        fi
        curr="${curr%.*}"
        inu=$((inu + curr * mult))
        mult=$((mult * 60))
        arg="$prev"
    done
    echo "$inu"
}

# Fungsi untuk menambah akun VMess
function add-vmess(){
    clear
    until [[ $user =~ ^[a-zA-Z0-9_.-]+$ && ${CLIENT_EXISTS} == '0' ]]; do
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│${NC} ${COLBG1}            ${WH}• Add Vmess Account •              ${NC} $COLOR1│ $NC"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        echo -e ""
        read -rp "  Username    : " -e user
        
        if [[ -z "$user" ]]; then
            echo -e "${RED}Username tidak boleh kosong${NC}"
            continue
        fi
        
        CLIENT_EXISTS=$(grep -w "$user" /etc/xray/config.json 2>/dev/null | wc -l)
        
        if [[ ${CLIENT_EXISTS} == '1' ]]; then
            clear
            echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
            echo -e "$COLOR1│ ${NC} ${COLBG1}            ${WH}• Add Vmess Account •             ${NC} $COLOR1│ $NC"
            echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
            echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
            echo -e "$COLOR1│                                                 │"
            echo -e "$COLOR1│${WH} Nama Duplikat Silahkan Buat Nama Lain.          $COLOR1│"
            echo -e "$COLOR1│                                                 │"
            echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
            read -n 1 -s -r -p "Press any key to back"
            add-vmess
        fi
    done
    
    until [[ $masaaktif =~ ^[0-9]+$ ]]; do
        read -p "  Masa Aktif  : " masaaktif
    done
    
    until [[ $iplim =~ ^[0-9]+$ ]]; do
        read -p "  Limit User  : " iplim
    done
    
    until [[ $Quota =~ ^[0-9]+$ ]]; do
        read -p "  Limit Quota : " Quota
    done
    
    exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
    uuid=$(cat /proc/sys/kernel/random/uuid)
    
    [[ ! -e /etc/vmess ]] && mkdir -p /etc/vmess
    
    if [[ ${iplim} == '0' ]]; then
        iplim="9999"
    fi
    
    if [[ ${Quota} == '0' ]]; then
        Quota="9999"
    fi
    
    c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
    d=$((${c} * 1024 * 1024 * 1024))
    
    if [[ ${c} != "0" ]]; then
        echo "${d}" > /etc/vmess/${user}
    fi
    
    echo "${iplim}" > /etc/vmess/${user}IP
    
    # Backup konfigurasi sebelum modifikasi
    cp /etc/xray/config.json /etc/xray/config.json.bak
    
    # Tambahkan konfigurasi ke xray
    sed -i '/#vmess$/a\#vm '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
    
    sed -i '/#vmessgrpc$/a\#vmg '"$user $exp $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
    
    # Buat konfigurasi VMess
    asu=$(cat<<EOF
{
"v": "2",
"ps": "${user}",
"add": "${domain}",
"port": "443",
"id": "${uuid}",
"aid": "0",
"net": "ws",
"path": "/vmess",
"type": "none",
"host": "${domain}",
"tls": "tls"
}
EOF
)
    
    ask=$(cat<<EOF
{
"v": "2",
"ps": "${user}",
"add": "${domain}",
"port": "80",
"id": "${uuid}",
"aid": "0",
"net": "ws",
"path": "/vmess",
"type": "none",
"host": "${domain}",
"tls": "none"
}
EOF
)
    
    grpc=$(cat<<EOF
{
"v": "2",
"ps": "${user}",
"add": "${domain}",
"port": "443",
"id": "${uuid}",
"aid": "0",
"net": "grpc",
"path": "vmess-grpc",
"type": "none",
"host": "${domain}",
"tls": "tls"
}
EOF
)
    
    vmesslink1="vmess://$(echo "$asu" | base64 -w 0)"
    vmesslink2="vmess://$(echo "$ask" | base64 -w 0)"
    vmesslink3="vmess://$(echo "$grpc" | base64 -w 0)"
    
    # Buat file konfigurasi OpenClash
    cat > /home/vps/public_html/vmess-$user.txt <<-END
_______________________________________________________
Format Vmess WS (CDN)
_______________________________________________________
- name: vmess-$user-WS (CDN)
  type: vmess
  server: ${domain}
  port: 443
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}
_______________________________________________________
Format Vmess WS (CDN) Non TLS
_______________________________________________________
- name: vmess-$user-WS (CDN) Non TLS
  type: vmess
  server: ${domain}
  port: 80
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}
_______________________________________________________
Format Vmess gRPC (SNI)
_______________________________________________________
- name: vmess-$user-gRPC (SNI)
  server: ${domain}
  port: 443
  type: vmess
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  network: grpc
  tls: true
  servername: ${domain}
  skip-cert-verify: true
  grpc-opts:
    grpc-service-name: vmess-grpc
_______________________________________________________
Link Vmess Account
_______________________________________________________
Link TLS : ${vmesslink1}
_______________________________________________________
Link NTLS : ${vmesslink2}
_______________________________________________________
Link gRPC : ${vmesslink3}
_______________________________________________________
END
    
    # Siapkan pesan untuk Telegram
    if [[ ${Quota} == '9999' ]]; then
        TEXT="
◇━━━━━━━━━━━━━━━━━◇
Premium Vmess Account
◇━━━━━━━━━━━━━━━━━◇
User         : ${user}
Domain       : ${domain}
Login Limit  : ${iplim} IP
ISP          : ${ISP}
CITY         : ${CITY}
Port TLS     : 443
Port NTLS    : 80, 8080
Port GRPC    : 443
UUID         : ${uuid}
AlterId      : 0
Security     : auto
Network      : WS or gRPC
Path         : /vmess
ServiceName  : vmess-grpc
◇━━━━━━━━━━━━━━━━━◇
Link TLS     :
${vmesslink1}
◇━━━━━━━━━━━━━━━━━◇
Link NTLS    :
${vmesslink2}
◇━━━━━━━━━━━━━━━━━◇
Link GRPC    :
${vmesslink3}
◇━━━━━━━━━━━━━━━━━◇
Format OpenClash :
https://$domain:81/vmess-$user.txt
◇━━━━━━━━━━━━━━━━━◇
Expired Until    : $exp
◇━━━━━━━━━━━━━━━━━◇
$author
◇━━━━━━━━━━━━━━━━━◇
"
    else
        TEXT="
◇━━━━━━━━━━━━━━━━━◇
Premium Vmess Account
◇━━━━━━━━━━━━━━━━━◇
User         : ${user}
Domain       : ${domain}
Login Limit  : ${iplim} IP
Quota Limit  : ${Quota} GB
ISP          : ${ISP}
CITY         : ${CITY}
Expired On   : $exp
Port TLS     : 443
Port NTLS    : 80, 8080
Port GRPC    : 443
UUID         : ${uuid}
AlterId      : 0
Security     : auto
Network      : WS or gRPC
Path         : /vmess
ServiceName  : vmess-grpc
◇━━━━━━━━━━━━━━━━━◇
Link TLS     :
${vmesslink1}
◇━━━━━━━━━━━━━━━━━◇
Link NTLS    :
${vmesslink2}
◇━━━━━━━━━━━━━━━━━◇
Link GRPC    :
${vmesslink3}
◇━━━━━━━━━━━━━━━━━◇
Format OpenClash :
https://$domain:81/vmess-$user.txt
◇━━━━━━━━━━━━━━━━━◇
$author
◇━━━━━━━━━━━━━━━━━◇
"
    fi
    
    # Kirim notifikasi Telegram jika tersedia
    if [[ -n "$CHATID" && -n "$KEY" ]]; then
        curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" "$URL" >/dev/null
    fi
    
    # Kirim notifikasi tambahan jika tersedia
    if [[ -e /etc/tele ]]; then
        echo "$TEXT" > /etc/notiftele
        bash /etc/tele
    fi
    
    # Notifikasi pembelian
    user2=$(echo "$user" | cut -c 1-3)
    TIME2=$(date +'%Y-%m-%d %H:%M:%S')
    TEXT2="
◇━━━━━━━━━━━━━━━━━━━◇
   PEMBELIAN VMESS SUCCES 
◇━━━━━━━━━━━━━━━━━━━◇
DOMAIN  : ${domain}
CITY    : $CITY
DATE    : ${TIME2} WIB
DETAIL  : Trx VMESS
USER    : ${user2}xxx
IP      : ${iplim} IP
DURASI  : $masaaktif Hari
◇━━━━━━━━━━━━━━━━━━━◇
Notif Pembelian Akun Vmess..
"
    
    if [[ -n "$CHATID2" && -n "$KEY2" ]]; then
        curl -s --max-time $TIMES -d "chat_id=$CHATID2&disable_web_page_preview=1&text=$TEXT2&parse_mode=html" "$URL2" >/dev/null
    fi
    
    # Tampilkan hasil
    clear
    echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1 ${NC} ${WH}• Premium Vmess Account • ${NC} $COLOR1 $NC" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}Username ${COLOR1}: ${WH}${user}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}ISP  ${COLOR1}: ${WH}$ISP" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}City ${COLOR1}: ${WH}$CITY" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}Domain  ${COLOR1}: ${WH}${domain}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}Limit IP${COLOR1}: ${WH}${iplim} User" | tee -a /etc/vmess/akun/log-create-${user}.log
    
    if [[ ${Quota} != '9999' ]]; then
        echo -e "$COLOR1${NC}${WH}Quota Limit  ${COLOR1}: ${WH}${Quota} GB" | tee -a /etc/vmess/akun/log-create-${user}.log
    fi
    
    echo -e "$COLOR1 ${NC} ${WH}Expired On ${COLOR1}: ${WH}$exp" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}Port TLS      ${COLOR1}: ${WH}443" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}Port NTLS    ${COLOR1}: ${WH}80,8080" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}Port gRPC     ${COLOR1}: ${WH}443" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}UUID         ${COLOR1}: ${WH}${uuid}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}alterId       ${COLOR1}: ${WH}0" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}Security      ${COLOR1}: ${WH}auto" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}Network       ${COLOR1}: ${WH}ws" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}Path          ${COLOR1}: ${WH}/vmess" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}ServiceName   ${COLOR1}: ${WH}vmess-grpc" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${COLOR1}Link TLS  ${WH}:    ${vmesslink1}${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${COLOR1}Link NTLS ${WH}:    ${vmesslink2}${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${COLOR1}Link GRPC ${WH}:    ${vmesslink3}${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}Format Openclash ${COLOR1}:" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1${NC}${WH}https://$domain:81/vmess-$user.txt${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1 ${NC} ${WH}    $author     " | tee -a /etc/vmess/akun/log-create-${user}.log
    echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
    echo "" | tee -a /etc/vmess/akun/log-create-${user}.log
    
    # Restart xray service
    systemctl restart xray > /dev/null 2>&1
    
    read -n 1 -s -r -p "Press any key to back on menu"
    main_menu
}

# Fungsi trial VMess
function trial-vmess(){
    clear
    echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
    echo -e "$COLOR1│${NC} ${COLBG1}           ${WH}• Trial Vmess Account •             ${NC} $COLOR1│ $NC"
    echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
    echo -e ""
    
    until [[ $timer =~ ^[0-9]+$ ]]; do
        read -p "  Expired (Minutes) : " timer
    done
    
    user="Trial-$(</dev/urandom tr -dc X-Z0-9 | head -c4)"
    iplim=1
    Quota=10
    uuid=$(cat /proc/sys/kernel/random/uuid)
    masaaktif=0
    
    [[ ! -e /etc/vmess ]] && mkdir -p /etc/vmess
    
    c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
    d=$((${c} * 1024 * 1024 * 1024))
    
    if [[ ${c} != "0" ]]; then
        echo "${d}" > /etc/vmess/${user}
    fi
    
    echo "${iplim}" > /etc/vmess/${user}IP
    exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
    
    # Tambahkan ke konfigurasi xray
    sed -i '/#vmess$/a\#vm '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
    
    sed -i '/#vmessgrpc$/a\#vmg '"$user $exp $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
    
    # Buat cron job untuk auto delete trial
    cat > /etc/cron.d/trialvmess${user} << EOF
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/$timer * * * * root /usr/bin/trial vmess $user $uuid $exp
EOF
    
    # Generate links (sama seperti fungsi add-vmess)
    asu=$(cat<<EOF
{
"v": "2",
"ps": "${user}",
"add": "${domain}",
"port": "443",
"id": "${uuid}",
"aid": "0",
"net": "ws",
"path": "/vmess",
"type": "none",
"host": "${domain}",
"tls": "tls"
}
EOF
)
    
    vmesslink1="vmess://$(echo "$asu" | base64 -w 0)"
    
    # Tampilkan hasil trial
    clear
    echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}"
    echo -e "$COLOR1 ${NC} ${WH}• Trial Premium Vmess Account • ${NC} $COLOR1 $NC"
    echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}"
    echo -e "$COLOR1 ${NC} ${WH}Username   ${COLOR1}: ${WH}${user}"
    echo -e "$COLOR1 ${NC} ${WH}Domain     ${COLOR1}: ${WH}${domain}"
    echo -e "$COLOR1 ${NC} ${WH}Expired On ${COLOR1}: ${WH}$timer Minutes"
    echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}"
    
    systemctl restart xray > /dev/null 2>&1
    read -n 1 -s -r -p "Press any key to back on menu"
    main_menu
}

# Fungsi cek VMess yang diperbaiki
function cek-vmess(){
    clear
    
    # Pastikan logging dikonfigurasi dengan benar
    fix_xray_logging
    
    # Tunggu sebentar untuk log terbaru
    sleep 2
    
    # Periksa apakah Xray berjalan
    if ! systemctl is-active --quiet xray; then
        echo "Service Xray tidak berjalan! Memulai ulang..."
        systemctl start xray
        sleep 3
    fi
    
    # Periksa file log
    if [[ ! -f /var/log/xray/access.log ]]; then
        echo "File log tidak ditemukan. Membuat file log..."
        touch /var/log/xray/access.log
        chown nobody:nogroup /var/log/xray/access.log
        systemctl restart xray
        sleep 3
    fi
    
    # Periksa ukuran log
    xrayy=$(wc -l < /var/log/xray/access.log 2>/dev/null || echo "0")
    if [[ $xrayy -le 5 ]]; then
        echo "Log entries sedikit, me-restart Xray..."
        systemctl restart xray
        sleep 3
    fi
    
    echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
    echo -e "$COLOR1│${NC} ${COLBG1}            ${WH}• VMESS USER ONLINE •              ${NC} $COLOR1│ $NC"
    echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
    echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
    
    # Ambil daftar user VMess dari config
    vm=($(grep "^#vmg" /etc/xray/config.json | awk '{print $2}' | sort -u))
    
    if [[ ${#vm[@]} -eq 0 ]]; then
        echo -e "$COLOR1│${NC} ${WH}Tidak ada user VMess yang ditemukan${NC} $COLOR1│"
        echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
        read -n 1 -s -r -p "Press any key to back on menu"
        main_menu
        return
    fi
    
    echo -n > /tmp/vm
    current_time=$(date +%s)
    
    for db1 in "${vm[@]}"; do
        # Coba beberapa format log yang berbeda
        # Format 1: email: username
        logvm1=$(grep "email: ${db1}" /var/log/xray/access.log 2>/dev/null | tail -n 50)
        
        # Format 2: username langsung
        logvm2=$(grep "${db1}" /var/log/xray/access.log 2>/dev/null | tail -n 50)
        
        # Format 3: dengan UUID
        uuid=$(grep "^#vmg.*${db1}" /etc/xray/config.json | awk '{print $4}')
        logvm3=""
        if [[ -n "$uuid" ]]; then
            logvm3=$(grep "${uuid}" /var/log/xray/access.log 2>/dev/null | tail -n 50)
        fi
        
        # Gabungkan semua hasil
        logvm=$(echo -e "$logvm1\n$logvm2\n$logvm3" | sort -u | grep -v "^$")
        
        if [[ -n "$logvm" ]]; then
            while IFS= read -r line; do
                if [[ -n "$line" ]]; then
                    # Parse log line - sesuaikan dengan format log Anda
                    # Contoh format: 2024/01/01 12:00:00 [Info] [1234567] email: user1 accepted tcp:1.2.3.4:443
                    
                    # Ekstrak timestamp
                    timestamp=$(echo "$line" | awk '{print $1" "$2}' | sed 's/\[.*\]//')
                    
                    # Ekstrak IP
                    ip=$(echo "$line" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
                    
                    # Konversi timestamp ke epoch (sesuaikan format)
                    if [[ -n "$timestamp" ]]; then
                        log_time=$(date -d "$timestamp" +%s 2>/dev/null || echo "0")
                        time_diff=$((current_time - log_time))
                        
                        # Jika koneksi dalam 60 detik terakhir
                        if [[ $time_diff -lt 60 && -n "$ip" ]]; then
                            # Cek apakah IP sudah ada di temporary file
                            if ! grep -q "${db1}.*${ip}" /tmp/vm; then
                                echo "${db1} ${timestamp} : ${ip}" >> /tmp/vm
                            fi
                        fi
                    fi
                fi
            done <<< "$logvm"
        fi
    done
    
    # Tampilkan hasil
    if [[ -s /tmp/vm ]]; then
        echo -e "$COLOR1│${NC} ${WH}User Online Ditemukan:${NC} $COLOR1│"
        echo -e "$COLOR1├═══════════════════════════════════════════════════┤${NC}"
        
        for vmuser in "${vm[@]}"; do
            vmhas=$(grep -c "^${vmuser}" /tmp/vm 2>/dev/null || echo "0")
            
            if [[ $vmhas -gt 0 ]]; then
                # Ambil informasi quota dan limit
                byt=$(cat "/etc/limit/vmess/${vmuser}" 2>/dev/null || echo "0")
                gb=$(convert ${byt} 2>/dev/null || echo "0 B")
                lim=$(cat "/etc/vmess/${vmuser}" 2>/dev/null || echo "0")
                lim2=$(convert ${lim} 2>/dev/null || echo "0 B")
                
                echo -e "$COLOR1│${NC} USERNAME : \033[0;33m$vmuser${NC}"
                echo -e "$COLOR1│${NC} IP LOGIN : \033[0;33m$vmhas${NC}"
                echo -e "$COLOR1│${NC} USAGE    : \033[0;33m$gb${NC}"
                echo -e "$COLOR1│${NC} LIMIT    : \033[0;33m$lim2${NC}"
                echo -e "$COLOR1├═══════════════════════════════════════════════════┤${NC}"
                
                # Tampilkan detail IP yang login
                grep "^${vmuser}" /tmp/vm | while read user time ip; do
                    echo -e "$COLOR1│${NC} ${WH}└─ IP: $ip at $time${NC}"
                done
                echo -e "$COLOR1├═══════════════════════════════════════════════════┤${NC}"
            fi
        done
    else
        echo -e "$COLOR1│${NC} ${WH}Tidak ada user yang sedang online${NC} $COLOR1│"
        echo -e "$COLOR1│${NC} ${WH}Kemungkinan penyebab:${NC} $COLOR1│"
        echo -e "$COLOR1│${NC} ${WH}1. Tidak ada koneksi aktif${NC} $COLOR1│"
        echo -e "$COLOR1│${NC} ${WH}2. Format log tidak sesuai${NC} $COLOR1│"
        echo -e "$COLOR1│${NC} ${WH}3. Logging tidak dikonfigurasi${NC} $COLOR1│"
    fi
    
    echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
    
    # Cleanup
    rm -f /tmp/vm
    
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    main_menu
}

# Fungsi renew VMess
function renew-vmess(){
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^#vmg " "/etc/xray/config.json")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        clear
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Renew Vmess Account ⇲      ${NC} $COLOR1 $NC"
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        echo "You have no existing clients!"
        echo ""
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        main_menu
    fi
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Renew Vmess Account ⇲      ${NC} $COLOR1 $NC"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo " Select the existing client you want to renew"
    echo " ketik [0] kembali kemenu"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo "     No  User   Expired"
    grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
            if [[ ${CLIENT_NUMBER} == '0' ]]; then
                main_menu
            fi
        fi
    done
    read -p "Expired (days): " masaaktif
    user=$(grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
    now=$(date +%Y-%m-%d)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(( (d1 - d2) / 86400 ))
    exp3=$(($exp2 + $masaaktif))
    exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
    sed -i "s/#vm $user $exp/#vm $user $exp4/g" /etc/xray/config.json
    sed -i "s/#vmg $user $exp/#vmg $user $exp4/g" /etc/xray/config.json
    clear
    TEXT="
◇━━━━━━━━━━━━━━◇
   XRAY VMESS RENEW
◇━━━━━━━━━━━━━━◇
DOMAIN   : ${domain}
ISP      : $ISP $CITY
USERNAME : $user
EXPIRED  : $exp4
◇━━━━━━━━━━━━━━◇
"
    if [[ -n "$CHATID" && -n "$KEY" ]]; then
        curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
    fi
    
    if [[ -e /etc/tele ]]; then
        echo "$TEXT" > /etc/notiftele
        bash /etc/tele
    fi
    
    systemctl restart xray > /dev/null 2>&1
    clear
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo " VMESS Account Was Successfully Renewed"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo " Client Name : $user"
    echo " Expired On  : $exp4"
    echo ""
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    main_menu
}

# Fungsi delete VMess
function del-vmess(){
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^#vmg " "/etc/xray/config.json")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Delete Vmess Account ⇲     ${NC} $COLOR1 $NC"
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        echo "You have no existing clients!"
        echo ""
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        read -n 1 -s -r -p "Press any key to back on menu"
        main_menu
    fi
    clear
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Delete Vmess Account ⇲     ${NC} $COLOR1 $NC"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo " Select the existing client you want to remove"
    echo " ketik [0] kembali kemenu"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo "     No  User   Expired"
    grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
            if [[ ${CLIENT_NUMBER} == '0' ]]; then
                main_menu
            fi
        fi
    done
    user=$(grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
    uuid=$(grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
    
    if [[ ! -e /etc/vmess/akundelete ]]; then
        echo "" > /etc/vmess/akundelete
    fi
    
    clear
    echo "### $user $exp $uuid" >> /etc/vmess/akundelete
    sed -i "/^#vmg $user $exp/,/^},{/d" /etc/xray/config.json
    sed -i "/^#vm $user $exp/,/^},{/d" /etc/xray/config.json
    rm -f /etc/vmess/${user}IP
    rm -f /home/vps/public_html/vmess-$user.txt
    rm -f /etc/vmess/${user}
    rm -f /etc/vmess/${user}login
    rm -f /etc/limit/vmess/${user}
    
    systemctl restart xray > /dev/null 2>&1
    clear
    
    TEXT="
◇━━━━━━━━━━━━━━◇
  XRAY VMESS DELETE
◇━━━━━━━━━━━━━━◇
DOMAIN   : ${domain}
ISP      : $ISP $CITY
USERNAME : $user
EXPIRED  : $exp
◇━━━━━━━━━━━━━━◇
Succes Delete this Username...
"
    if [[ -n "$CHATID" && -n "$KEY" ]]; then
        curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
    fi
    
    if [[ -e /etc/tele ]]; then
        echo "$TEXT" > /etc/notiftele
        bash /etc/tele
    fi
    
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo " Vmess Account Deleted Successfully"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo " Client Name : $user"
    echo " Expired On  : $exp"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    main_menu
}

# Fungsi list config VMess
function list-vmess(){
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^#vmg " "/etc/xray/config.json")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        clear
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Config Vmess Account ⇲     ${NC} $COLOR1 $NC"
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        echo "You have no existing clients!"
        echo ""
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        read -n 1 -s -r -p "Press any key to back on menu"
        main_menu
    fi
    clear
    echo ""
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Config Vmess Account ⇲     ${NC} $COLOR1 $NC"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo " Select the existing client to view the config"
    echo " ketik [0] kembali kemenu"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo "     No  User   Expired"
    grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
            if [[ ${CLIENT_NUMBER} == '0' ]]; then
                main_menu
            fi
        fi
    done
    clear
    user=$(grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    
    if [[ -f /etc/vmess/akun/log-create-${user}.log ]]; then
        cat /etc/vmess/akun/log-create-${user}.log
    else
        echo "Log file untuk user $user tidak ditemukan."
    fi
    
    read -n 1 -s -r -p "Press any key to back on menu"
    main_menu
}

# Fungsi limit VMess
function limit-vmess(){
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^#vmg " "/etc/xray/config.json")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        clear
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Limit Vmess Account ⇲      ${NC} $COLOR1 $NC"
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        echo "You have no existing clients!"
        echo ""
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        main_menu
    fi
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Limit Vmess Account ⇲      ${NC} $COLOR1 $NC"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo " Select the existing client you want to change limit"
    echo " ketik [0] kembali kemenu"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo "     No  User   Expired"
    grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
            if [[ ${CLIENT_NUMBER} == '0' ]]; then
                main_menu
            fi
        fi
    done
    clear
    until [[ $iplim =~ ^[0-9]+$ ]]; do
        read -p "Limit User (IP) or 0 Unlimited: " iplim
    done
    until [[ $Quota =~ ^[0-9]+$ ]]; do
        read -p "Limit User (GB) or 0 Unlimited: " Quota
    done
    
    if [[ ! -e /etc/vmess ]]; then
        mkdir -p /etc/vmess
    fi
    
    if [[ ${iplim} = '0' ]]; then
        iplim="9999"
    fi
    
    if [[ ${Quota} = '0' ]]; then
        Quota="9999"
    fi
    
    user=$(grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    echo "${iplim}" > /etc/vmess/${user}IP
    c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
    d=$((${c} * 1024 * 1024 * 1024))
    
    if [[ ${c} != "0" ]]; then
        echo "${d}" > /etc/vmess/${user}
    fi
    
    TEXT="
◇━━━━━━━━━━━━━━◇
  XRAY VMESS IP LIMIT
◇━━━━━━━━━━━━━━◇
DOMAIN   : ${domain}
ISP      : $ISP $CITY
USERNAME : $user
IP LIMIT NEW : $iplim IP
QUOTA LIMIT NEW : $Quota GB
◇━━━━━━━━━━━━━━◇
Succes Change this Limit...
"
    if [[ -n "$CHATID" && -n "$KEY" ]]; then
        curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
    fi
    
    if [[ -e /etc/tele ]]; then
        echo "$TEXT" > /etc/notiftele
        bash /etc/tele
    fi
    
    clear
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo " VMESS Account Was Successfully Change Limit"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo " Client Name : $user"
    echo " Limit IP    : $iplim IP"
    echo " Limit Quota : $Quota GB"
    echo ""
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    main_menu
}

# Fungsi setting login
function login-vmess(){
    clear
    echo -e "$COLOR1╭══════════════════════════════════════════╮${NC}"
    echo -e "$COLOR1│ \033[1;37mPlease select a your Choice              $COLOR1│${NC}"
    echo -e "$COLOR1╰══════════════════════════════════════════╯${NC}"
    echo -e ""
    echo -e "$COLOR1╭══════════════════════════════════════════╮${NC}"
    echo -e "$COLOR1│  [ 1 ]  \033[1;37mAUTO LOCKED USER ALL XRAY      ${NC}"
    echo -e "$COLOR1│  [ 2 ]  \033[1;37mAUTO DELETE USER ALL XRAY    ${NC}"
    echo -e "$COLOR1│  [ 0 ]  \033[1;37mBACK TO MENU    ${NC}"
    echo -e "$COLOR1╰══════════════════════════════════════════╯${NC}"
    until [[ $lock =~ ^[0-2]+$ ]]; do
        read -p "    select numbers 1/2 : " lock
    done
    
    if [[ $lock == "0" ]]; then
        main_menu
    elif [[ $lock == "1" ]]; then
        clear
        echo "lock" > /etc/typexray
        echo -e "$COLOR1╭═══════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│${NC} ${COLBG1}          ${WH}• SETTING MULTI LOGIN •            ${NC} $COLOR1│ $NC"
        echo -e "$COLOR1╰═══════════════════════════════════════════════╯${NC}"
        echo -e "$COLOR1╭═══════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│$NC Succes Ganti Auto Lock  ${NC}"
        echo -e "$COLOR1│$NC Jika User Melanggar auto lock Account. ${NC}"
        echo -e "$COLOR1╰═══════════════════════════════════════════════╯${NC}"
        sleep 1
    elif [[ $lock == "2" ]]; then
        clear
        echo "delete" > /etc/typexray
        echo -e "$COLOR1╭═══════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│${NC} ${COLBG1}          ${WH}• SETTING MULTI LOGIN •            ${NC} $COLOR1│ $NC"
        echo -e "$COLOR1╰═══════════════════════════════════════════════╯${NC}"
        echo -e "$COLOR1╭═══════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│$NC Succes Ganti Auto Delete Account ${NC}"
        echo -e "$COLOR1│$NC Jika User Melanggar auto Delete Account. ${NC}"
        echo -e "$COLOR1╰═══════════════════════════════════════════════╯${NC}"
        sleep 1
    fi
    
    read -n 1 -s -r -p "Press any key to back on menu"
    main_menu
}

# Fungsi unlock user
function lock-vmess(){
    clear
    echo "Fungsi unlock user belum diimplementasi"
    read -n 1 -s -r -p "Press any key to back on menu"
    main_menu
}

# Fungsi unlock quota
function quota-user(){
    clear
    echo "Fungsi unlock quota belum diimplementasi"
    read -n 1 -s -r -p "Press any key to back on menu"
    main_menu
}

# Fungsi restore akun
function res-user(){
    clear
    echo "Fungsi restore akun belum diimplementasi"
    read -n 1 -s -r -p "Press any key to back on menu"
    main_menu
}

# Fungsi utama menu
function main_menu(){
    clear
    echo -e " $COLOR1╭════════════════════════════════════════════════════╮${NC}"
    echo -e " $COLOR1│${NC} ${COLBG1}            ${WH}• VMESS PANEL MENU •                  ${NC} $COLOR1│ $NC"
    echo -e " $COLOR1╰════════════════════════════════════════════════════╯${NC}"
    echo -e " $COLOR1╭════════════════════════════════════════════════════╮${NC}"
    echo -e " $COLOR1│ $NC ${WH}[${COLOR1}01${WH}]${NC} ${COLOR1}• ${WH}ADD AKUN${NC}         ${WH}[${COLOR1}06${WH}]${NC} ${COLOR1}• ${WH}CEK USER CONFIG${NC}    $COLOR1│ $NC"
    echo -e " $COLOR1│ $NC ${WH}[${COLOR1}02${WH}]${NC} ${COLOR1}• ${WH}TRIAL AKUN${NC}       ${WH}[${COLOR1}07${WH}]${NC} ${COLOR1}• ${WH}CHANGE USER LIMIT${NC}  $COLOR1│ $NC"
    echo -e " $COLOR1│ $NC ${WH}[${COLOR1}03${WH}]${NC} ${COLOR1}• ${WH}RENEW AKUN${NC}       ${WH}[${COLOR1}08${WH}]${NC} ${COLOR1}• ${WH}SETTING LOCK LOGIN${NC} $COLOR1│ $NC"
    echo -e " $COLOR1│ $NC ${WH}[${COLOR1}04${WH}]${NC} ${COLOR1}• ${WH}DELETE AKUN${NC}      ${WH}[${COLOR1}09${WH}]${NC} ${COLOR1}• ${WH}UNLOCK USER LOGIN${NC}  $COLOR1│ $NC"
    echo -e " $COLOR1│ $NC ${WH}[${COLOR1}05${WH}]${NC} ${COLOR1}• ${WH}CEK USER LOGIN${NC}   ${WH}[${COLOR1}10${WH}]${NC} ${COLOR1}• ${WH}UNLOCK USER QUOTA ${NC} $COLOR1│ $NC"
    echo -e " $COLOR1│ $NC ${WH}[${COLOR1}00${WH}]${NC} ${COLOR1}• ${WH}GO BACK${NC}          ${WH}[${COLOR1}11${WH}]${NC} ${COLOR1}• ${WH}RESTORE AKUN   ${NC}    $COLOR1│ $NC"
    echo -e " $COLOR1╰════════════════════════════════════════════════════╯${NC}"
    echo -e " $COLOR1╭═════════════════════════ ${WH}BY${NC} ${COLOR1}═══════════════════════╮ ${NC}"
    printf "                      ${COLOR1}%3s${NC} ${WH}%0s${NC} ${COLOR1}%3s${NC}\n" "• " "$author" " •"
    echo -e " $COLOR1╰════════════════════════════════════════════════════╯${NC}"
    echo -e ""
    echo -ne " ${WH}Select menu ${COLOR1}: ${WH}"
    read opt
    
    case $opt in
        01|1) clear; add-vmess ;;
        02|2) clear; trial-vmess ;;
        03|3) clear; renew-vmess ;;
        04|4) clear; del-vmess ;;
        05|5) clear; cek-vmess ;;
        06|6) clear; list-vmess ;;
        07|7) clear; limit-vmess ;;
        08|8) clear; login-vmess ;;
        09|9) clear; lock-vmess ;;
        10|10) clear; quota-user ;;
        11|11) clear; res-user ;;
        00|0) clear; echo "Keluar dari menu"; exit 0 ;;
        *) clear; main_menu ;;
    esac
}

# Jalankan menu utama
main_menu
