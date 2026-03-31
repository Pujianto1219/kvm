#!/bin/bash

# Fungsi loading bar yang ditingkatkan
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    PROCESS_NAME="$3"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    
    tput civis
    echo -ne "  \033[0;33m${PROCESS_NAME}.. \033[1;37m- \033[0;33m["
    
    # Loading bar dengan animasi yang lebih menarik
    local progress=0
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m█"
            sleep 0.1s
            progress=$((progress + 1))
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33m${PROCESS_NAME}... \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m Berhasil !\033[1;37m"
    tput cnorm
}

# Fungsi loading untuk download dengan progress
download_with_progress() {
    local url="$1"
    local filename="$2"
    local description="$3"
    
    echo -e "\033[0;36m╭─────────────────────────────────────────╮\033[0m"
    echo -e "\033[0;36m│ \033[1;37mMengunduh: $description\033[0;36m │\033[0m"
    echo -e "\033[0;36m╰─────────────────────────────────────────╯\033[0m"
    
    # Simulasi progress download
    echo -ne "\033[0;33mProgress: \033[0;32m["
    for ((i=0; i<=20; i++)); do
        echo -ne "█"
        sleep 0.1
    done
    echo -e "]\033[1;32m 100% Selesai!\033[0m"
    
    # Download sebenarnya
    wget "$url" -O "$filename" >/dev/null 2>&1
    chmod +x "$filename"
}

# Fungsi loading untuk instalasi dengan animasi
install_with_animation() {
    local script_name="$1"
    local process_name="$2"
    
    echo -e "\033[0;35m╭─────────────────────────────────────────╮\033[0m"
    echo -e "\033[0;35m│ \033[1;37mMenginstal: $process_name\033[0;35m │\033[0m"
    echo -e "\033[0;35m╰─────────────────────────────────────────╯\033[0m"
    
    # Animasi loading dengan spinner
    local spinner='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    
    # Jalankan script di background
    ./"$script_name" >/dev/null 2>&1 &
    local pid=$!
    
    echo -ne "\033[0;33mMemproses: "
    while kill -0 $pid 2>/dev/null; do
        printf "\b${spinner:$i:1}"
        i=$(( (i+1) % ${#spinner} ))
        sleep 0.1
    done
    
    echo -e "\b\033[1;32m✓ Selesai!\033[0m"
    wait $pid
}

function CEKIP () {
MYIP=$(curl -sS ipv4.icanhazip.com)
IPVPS=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $4}')
if [[ $MYIP == $IPVPS ]]; then
domain
Casper2
#botwa
else
  #key2
  domain
  Casper2
  #botwa
fi
}

clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
BIBlue='\033[1;94m'       # Blue
BGCOLOR='\e[1;97;101m'    # WHITE RED
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

cd /root
if [ "${EUID}" -ne 0 ]; then
echo "You need to run this script as root"
exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
echo "OpenVZ is not supported"
exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi

secs_to_human() {
echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}

rm -rf /etc/rmbl
mkdir -p /etc/rmbl
mkdir -p /etc/rmbl/theme
mkdir -p /var/lib/ >/dev/null 2>&1
echo "IP=" >> /var/lib/ipvps.conf

clear
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR}             MASUKKAN NAMA KAMU         ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $name =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan Nama Kamu Disini tanpa spasi : " -e name
done
rm -rf /etc/profil
echo "$name" > /etc/profil
echo ""
clear
author=$(cat /etc/profil)
echo ""
echo ""

function domain(){
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mUpdate Domain.. \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33mUpdate Domain... \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m Succes !\033[1;37m"
    tput cnorm
}

res1() {
wget https://raw.githubusercontent.com/Pujianto1219/kvm/main/install/rmbl.sh && chmod +x rmbl.sh && ./rmbl.sh
clear
}
res2() {
wget https://raw.githubusercontent.com/RMBL-VPN/v1/main/install/r1.sh && chmod +x cr1.sh && ./per1.sh
clear
}
res3() {
wget https://raw.githubusercontent.com/RMBL-VPN/v1/main/install/c2.sh && chmod +x c2.sh && ./cr2.sh
clear
}
res4() {
wget https://raw.githubusercontent.com/RMBL-VPN/v1/main/install/r3.sh && chmod +x r3.sh && ./r3.sh
clear
}

clear
cd
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ \033[1;37mPlease select a your Choice to Set Domain${BIBlue}│${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo -e " "
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│  [ 1 ]  \033[1;37mDomain kamu sendiri       ${NC}"
#echo -e "${BIBlue}│  [ 2 ]  \033[1;37mDomain yang punya script  ${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
until [[ $domain =~ ^[132]+$ ]]; do 
read -p "   Please select numbers 1  : " domain
done

if [[ $domain == "1" ]]; then
clear
echo -e  "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e  "${BIBlue}│              \033[1;37mTERIMA KASIH                ${BIBlue}│${NC}"
echo -e  "${BIBlue}│         \033[1;37mSUDAH MENGGUNAKAN SCRIPT         ${BIBlue}│${NC}"
echo -e  "${BIBlue}│              \033[1;37m VPN ACIL-SHOP              ${BIBlue}│${NC}"
echo -e  "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $dnss =~ ^[a-zA-Z0-9_.-]+$ ]]; do 
read -rp "Masukan domain kamu Disini : " -e dnss
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dnss" > /root/domain
echo "$dnss" > /root/scdomain
echo "$dnss" > /etc/xray/scdomain
echo "$dnss" > /etc/v2ray/scdomain
echo "$dnss" > /etc/xray/domain
echo "$dnss" > /etc/v2ray/domain
echo "IP=$dnss" > /var/lib/ipvps.conf
echo ""
cd
sleep 1
clear
rm /root/subdomainx
clear
fi

if [[ $domain == "2" ]]; then
clear
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ \033[1;37m    Pilih Sub-Domain           ${BIBlue}│${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo -e " "
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│  [ 1 ]  \033[1;37mDomain xxxx.vpn-ACIL-SHOP.my.id          ${NC}"
echo -e "${BIBlue}│  [ 2 ]  \033[1;37mDomain xxxx.vvpnstore.my.id          ${NC}"
echo -e "${BIBlue}│  [ 3 ]  \033[1;37mDomain xxxx.aivpn.my.id          ${NC}"
echo -e "${BIBlue}│  [ 4 ]  \033[1;37mDomain xxxx.aivpn.biz.id          ${NC}"
echo -e "${BIBlue}│  [ 5 ]  \033[1;37mDomain xxxx.vpnx.my.id          ${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo -e "${BIBlue} kata (xxxx) nanti akan diganti dengan nama kalian${NC}"
until [[ $domain2 =~ ^[1-5]+$ ]]; do 
read -p "  Pilih Domain yg anda suka 1-5 : " domain2
done
fi

if [[ $domain2 == "1" ]]; then
clear
echo -e  "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e  "${BIBlue}│  \033[1;37m xxxx.vpn-ACIL-SHOP.my.id        ${BIBlue}│${NC}"
echo -e  "${BIBlue}│    \033[1;37mxxxx jadi subdomain nama kamu               ${BIBlue}│${NC}"
echo -e  "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $dn1 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan subdomain kamu Disini tanpa spasi : " -e dn1
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
mkdir -p /etc/per
touch /etc/per/id
touch /etc/per/token
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dn1" > /root/subdomainx
cd
sleep 1
fun_bar 'res1' 'Setup Domain'
clear
rm /root/subdomainx
elif [[ $domain2 == "2" ]]; then
clear
echo -e  "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e  "${BIBlue}│  \033[1;37m  xxxx.vvpnstore.my.id         ${BIBlue}│${NC}"
echo -e  "${BIBlue}│    \033[1;37mxxxx jadi subdomain nama kamu               ${BIBlue}│${NC}"
echo -e  "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $dn2 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan subdomain kamu Disini tanpa spasi : " -e dn2
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
mkdir -p /etc/per
touch /etc/per/id
touch /etc/per/token
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dn2" > /root/subdomainx
cd
sleep 1
fun_bar 'res2' 'Setup Domain'
clear
rm /root/subdomainx
elif [[ $domain2 == "3" ]]; then
clear
echo -e  "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e  "${BIBlue}│  \033[1;37m xxxx.aivpn.my.id       ${BIBlue}│${NC}"
echo -e  "${BIBlue}│    \033[1;37m xxxx jadi subdomain nama kamu               ${BIBlue}│${NC}"
echo -e  "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $dn3 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan subdomain kamu Disini tanpa spasi : " -e dn3
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
mkdir -p /etc/per
touch /etc/per/id
touch /etc/per/token
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dn3" > /root/subdomainx
cd
sleep 1
fun_bar 'res3' 'Setup Domain'
clear
rm /root/subdomainx
elif [[ $domain2 == "4" ]]; then
clear
echo -e  "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e  "${BIBlue}│  \033[1;37m xxxx.aivpn.biz.id        ${BIBlue}│${NC}"
echo -e  "${BIBlue}│    \033[1;37mxxxx jadi subdomain nama kamu               ${BIBlue}│${NC}"
echo -e  "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $dn4 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan subdomain kamu Disini tanpa spasi : " -e dn4
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
mkdir -p /etc/per
touch /etc/per/id
touch /etc/per/token
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dn4" > /root/subdomainx
cd
sleep 1
fun_bar 'res4' 'Setup Domain'
clear
rm /root/subdomainx
elif [[ $domain2 == "5" ]]; then
clear
echo -e  "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e  "${BIBlue}│  \033[1;37m  xxxx.vpnx.my.id       ${BIBlue}│${NC}"
echo -e  "${BIBlue}│    \033[1;37mxxxx jadi subdomain nama kamu               ${BIBlue}│${NC}"
echo -e  "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $dn5 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan subdomain kamu Disini tanpa spasi : " -e dn5
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
mkdir -p /etc/per
touch /etc/per/id
touch /etc/per/token
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dn5" > /root/subdomainx
cd
sleep 1
fun_bar 'res5' 'Setup Domain'
fi

if [[ $domain == "3" ]]; then
clear
echo -e  "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e  "${BIBlue}│              \033[1;37mTERIMA KASIH                ${BIBlue}│${NC}"
echo -e  "${BIBlue}│         \033[1;37mSUDAH MENGGUNAKAN SCRIPT         ${BIBlue}│${NC}"
echo -e  "${BIBlue}│                \033[1;37m VPN ACIL-SHOP              ${BIBlue}│${NC}"
echo -e  "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $dns1 =~ ^[a-zA-Z0-9_.-]+$ ]]; do 
read -rp "Masukan domain kamu Disini : " -e dns1
done
echo ""
echo "$dns1" > /etc/xray/domain
echo "$dns1" > /etc/v2ray/domain
echo "IP=$dns1" > /var/lib/ipvps.conf
clear
echo ""
echo -e  "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e  "${BIBlue}│              \033[1;37mTERIMA KASIH                ${BIBlue}│${NC}"
echo -e  "${BIBlue}│         \033[1;37mSUDAH MENGGUNAKAN SCRIPT         ${BIBlue}│${NC}"
echo -e  "${BIBlue}│                \033[1;37m VPN ACIL-SHOP              ${BIBlue}│${NC}"
echo -e  "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $dns2 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan Domain SlowDNS kamu Disini : " -e dns2
done
echo $dns2 >/etc/xray/dns
fi
}

# Membuat file tema
cat <<EOF>> /etc/rmbl/theme/green
BG : \E[40;1;42m
TEXT : \033[0;32m
EOF
cat <<EOF>> /etc/rmbl/theme/yellow
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
cat <<EOF>> /etc/rmbl/theme/red
BG : \E[40;1;41m
TEXT : \033[0;31m
EOF
cat <<EOF>> /etc/rmbl/theme/blue
BG : \E[40;1;44m
TEXT : \033[0;34m
EOF
cat <<EOF>> /etc/rmbl/theme/magenta
BG : \E[40;1;45m
TEXT : \033[0;35m
EOF
cat <<EOF>> /etc/rmbl/theme/cyan
BG : \E[40;1;46m
TEXT : \033[0;36m
EOF
cat <<EOF>> /etc/rmbl/theme/lightgray
BG : \E[40;1;47m
TEXT : \033[0;37m
EOF
cat <<EOF>> /etc/rmbl/theme/darkgray
BG : \E[40;1;100m
TEXT : \033[0;90m
EOF
cat <<EOF>> /etc/rmbl/theme/lightred
BG : \E[40;1;101m
TEXT : \033[0;91m
EOF
cat <<EOF>> /etc/rmbl/theme/lightgreen
BG : \E[40;1;102m
TEXT : \033[0;92m
EOF
cat <<EOF>> /etc/rmbl/theme/lightyellow
BG : \E[40;1;103m
TEXT : \033[0;93m
EOF
cat <<EOF>> /etc/rmbl/theme/lightblue
BG : \E[40;1;104m
TEXT : \033[0;94m
EOF
cat <<EOF>> /etc/rmbl/theme/lightmagenta
BG : \E[40;1;105m
TEXT : \033[0;95m
EOF
cat <<EOF>> /etc/rmbl/theme/lightcyan
BG : \E[40;1;106m
TEXT : \033[0;96m
EOF
cat <<EOF>> /etc/rmbl/theme/color.conf
lightcyan
EOF

function Casper2(){
cd
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
clear
wget https://raw.githubusercontent.com/Pujianto1219/kvm/main/tools.sh &> /dev/null
chmod +x tools.sh 
bash tools.sh
clear
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt install git curl -y >/dev/null 2>&1
apt install python -y >/dev/null 2>&1
}

function Casper3(){
echo -e "\033[1;96m"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                    🚀 MEMULAI INSTALASI VPN 🚀               ║"
echo "║                     Script Premium by ACIL-SHOP              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "\033[0m"
sleep 2

# 1. SSH & OpenVPN Installation dengan loading
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR}  PROCESS INSTALLED SSH & OVVPN         ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"

download_with_progress "https://raw.githubusercontent.com/Pujianto1219/kvm/main/install/ssh-vpn.sh" "ssh-vpn.sh" "SSH & OpenVPN Script"
install_with_animation "ssh-vpn.sh" "SSH & OpenVPN Server"
clear

# 2. Xray Installation dengan loading
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR}       PROCESS INSTALLED XRAY           ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"

download_with_progress "https://raw.githubusercontent.com/Pujianto1219/kvm/main/install/ins-xray.sh" "ins-xray.sh" "Xray Core"
install_with_animation "ins-xray.sh" "Xray Protocol"
clear

# 3. WebSocket SSH Installation dengan loading
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR}      PROCESS INSTALLED WEBSOCKET SSH   ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"

download_with_progress "https://raw.githubusercontent.com/Pujianto1219/kvm/main/sshws/insshws.sh" "insshws.sh" "WebSocket SSH"
install_with_animation "insshws.sh" "WebSocket SSH Tunnel"
clear

# 4. Backup Menu Installation dengan loading
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR}      PROCESS INSTALLED BACKUP MENU     ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"

download_with_progress "https://raw.githubusercontent.com/Pujianto1219/kvm/main/install/set-br.sh" "set-br.sh" "Backup & Restore Menu"
install_with_animation "set-br.sh" "Backup System"
clear

# 5. Extra Menu Installation dengan loading
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR}          DOWNLOAD EXTRA MENU           ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"

download_with_progress "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/update.sh" "update.sh" "Extra Menu & Tools"
install_with_animation "update.sh" "Extra Menu System"
clear

# 6. UDP Custom Installation dengan loading
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR}          DOWNLOAD UDP COSTUM           ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"

download_with_progress "https://raw.githubusercontent.com/Pujianto1219/kvm/main/install/udp-custom.sh" "udp-custom.sh" "UDP Custom for Gaming"
install_with_animation "udp-custom.sh" "UDP Custom Protocol"
clear

# 7. NoobzVPN Installation dengan loading
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR}    PROCESS INSTALLED NOOBZVPNS         ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"

echo -e "\033[0;36m╭─────────────────────────────────────────╮\033[0m"
echo -e "\033[0;36m│ \033[1;37mMengunduh: NoobzVPN Package\033[0;36m │\033[0m"
echo -e "\033[0;36m╰─────────────────────────────────────────╯\033[0m"

# Progress untuk download zip
echo -ne "\033[0;33mProgress: \033[0;32m["
wget https://raw.githubusercontent.com/Pujianto1219/kvm/main/noobz/noobzvpns.zip >/dev/null 2>&1 &
local pid=$!
while kill -0 $pid 2>/dev/null; do
    echo -ne "█"
    sleep 0.2
done
echo -e "]\033[1;32m 100% Selesai!\033[0m"

echo -e "\033[0;35m╭─────────────────────────────────────────╮\033[0m"
echo -e "\033[0;35m│ \033[1;37mMenginstal: NoobzVPN Service\033[0;35m │\033[0m"
echo -e "\033[0;35m╰─────────────────────────────────────────╯\033[0m"

unzip noobzvpns.zip >/dev/null 2>&1
chmod +x noobzvpns/*
cd noobzvpns

# Animasi untuk instalasi NoobzVPN
local spinner='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
local i=0
bash install.sh >/dev/null 2>&1 &
local pid=$!

echo -ne "\033[0;33mMemproses: "
while kill -0 $pid 2>/dev/null; do
    printf "\b${spinner:$i:1}"
    i=$(( (i+1) % ${#spinner} ))
    sleep 0.1
done
echo -e "\b\033[1;32m✓ Selesai!\033[0m"

cd ..
rm -rf noobzvpns
systemctl restart noobzvpns >/dev/null 2>&1
clear

# 8. Limit Xray Installation dengan loading
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR}    PROCESS INSTALLED LIMIT XRAY        ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"

download_with_progress "https://raw.githubusercontent.com/Pujianto1219/kvm/main/bin/limit.sh" "limit.sh" "Limit Xray System"
install_with_animation "limit.sh" "Limit Xray Configuration"
clear

# 9. Trojan-GO Installation dengan loading
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR}    PROCESS INSTALLED TROJAN-GO         ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"

download_with_progress "https://raw.githubusercontent.com/Pujianto1219/kvm/main/install/ins-trgo.sh" "ins-trgo.sh" "Trojan-GO Protocol"
install_with_animation "ins-trgo.sh" "Trojan-GO Server"
clear


# Menampilkan summary instalasi
echo -e "\033[1;92m"
echo "╔═════════════════════════════════════════════════════════╗"
echo "║                    ✅ INSTALASI SELESAI ✅               "
echo "║"
echo "║  📦 Komponen yang berhasil diinstal:"
echo "║  ✓ SSH & OpenVPN Server"
echo "║  ✓ Xray Protocol"
echo "║  ✓ WebSocket SSH Tunnel"
echo "║  ✓ Backup & Restore System"
echo "║  ✓ Extra Menu & Tools"
echo "║  ✓ UDP Custom for Gaming"
echo "║  ✓ NoobzVPN Service"
echo "║  ✓ Limit Xray System"
echo "║  ✓ Trojan-GO Protocol"
echo "╚═════════════════════════════════════════════════════════╝"
echo -e "\033[0m"
sleep 3
}

function iinfo(){
domain=$(cat /etc/xray/domain)
TIMES="10"
CHATID="6355497501"
KEY="7958219161:AAE-qCrUNC8CDzltezAl8kgSahxe16iW6K4"
URL="https://api.telegram.org/bot$KEY/sendMessage"
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
domain=$(cat /etc/xray/domain) 
TIME=$(date +'%Y-%m-%d %H:%M:%S')
RAMMS=$(free -m | awk 'NR==2 {print $2}')
MODEL2=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
MYIP=$(curl -sS ipv4.icanhazip.com)
IZIN=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $3}' )
d1=$(date -d "$IZIN" +%s)
d2=$(date -d "$today" +%s)
EXP=$(( (d1 - d2) / 86400 ))

TEXT="
<code>━━━━━━━━━━━━━━━━━━━━</code>
<code>⚠️ AUTOSCRIPT PREMIUM ⚠️</code>
<code>━━━━━━━━━━━━━━━━━━━━</code>
<code>NAME : </code><code>${author}</code>
<code>TIME : </code><code>${TIME} WIB</code>
<code>DOMAIN : </code><code>${domain}</code>
<code>IP : </code><code>${MYIP}</code>
<code>ISP : </code><code>${ISP} $CITY</code>
<code>OS LINUX : </code><code>${MODEL2}</code>
<code>RAM : </code><code>${RAMMS} MB</code>
<code>EXP SCRIPT : </code><code>$EXP Days</code>
<code>━━━━━━━━━━━━━━━━━━━━</code>
<i> Notifikasi Installer Script...</i>
"'&reply_markup={"inline_keyboard":[[{"text":"ᴏʀᴅᴇʀ","url":"https://t.me/AcilOffcial wa.me/+6287733994799"},{"text":"GRUP","url":"https://t.me/Aciltestimoni"}]]}'
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
clear
}

# Menjalankan script utama
CEKIP
Casper3

# Setup profile
cat> /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile

# Cleanup
if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi

history -c
serverV=$( curl -sS https://raw.githubusercontent.com/Pujianto1219/kvm/main/versi  )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi

cd
curl -sS ifconfig.me > /etc/myipvps
curl -s ipinfo.io/city?token=75082b4831f909 >> /etc/xray/city
curl -s ipinfo.io/org?token=75082b4831f909  | cut -d " " -f 2-10 >> /etc/xray/isp

# Cleanup script files
rm /root/setup.sh >/dev/null 2>&1
rm /root/slhost.sh >/dev/null 2>&1
rm /root/ssh-vpn.sh >/dev/null 2>&1
rm /root/ins-xray.sh >/dev/null 2>&1
rm /root/insshws.sh >/dev/null 2>&1
rm /root/set-br.sh >/dev/null 2>&1
rm /root/update.sh >/dev/null 2>&1
rm /root/slowdns.sh >/dev/null 2>&1

# Setup noobz directory
rm -rf /etc/noobz
mkdir -p /etc/noobz
echo "" > /etc/xray/noob

# Menampilkan waktu instalasi
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
sleep 3
echo  ""
cd

# Kirim notifikasi
iinfo
rm -rf *

# Final message
echo -e "${BIBlue}╭════════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR} INSTALL SCRIPT SELESAI..                 ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰════════════════════════════════════════════╯${NC}"
echo  ""
sleep 4

# Reboot confirmation
echo -e "[ ${yell}WARNING${NC} ] Do you want to reboot now ? (y/n)? "; read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi