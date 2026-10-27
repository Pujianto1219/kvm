#!/bin/bash
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
colornow=$(cat /etc/rmbl/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/rmbl/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/rmbl/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
ipsaya=$(wget -qO- ifconfig.me)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/Pujianto1219/ip/main/ip"
checking_sc() {
useexp=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
if [[ $date_list < $useexp ]]; then
echo -ne
else
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}          ${WH}• AUTOSCRIPT PREMIUM •               ${NC} $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "            ${RED}PERMISSION DENIED !${NC}"
echo -e "   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}"
echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
echo -e "             \033[0;33mContact Your Admin ${NC}"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
systemctl stop nginx
systemctl stop kyt
systemctl stop xray
systemctl stop ws-stunnel
exit
fi
}
checking_sc
cd
ipsaya=$(wget -qO- ifconfig.me)
cd /etc
nmap -p 22 $ipsaya > cekip
cpu=$(grep -c -E "open" "cekip")
if [[ ${cpu} == '0' ]]; then
apt install nmap -y
shutdown -r now
fi
cd
today=$(date -d "0 days" +"%Y-%m-%d")
Exp2=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $ipsaya | awk '{print $3}')
d1=$(date -d "$Exp2" +%s)
d2=$(date -d "$today" +%s)
certificate=$(( (d1 - d2) / 86400 ))
echo "$certificate Hari" > /etc/scdurasi
vnstat_profile=$(vnstat | sed -n '3p' | awk '{print $1}' | grep -o '[^:]*')
vnstat -i ${vnstat_profile} >/etc/t1
bulan=$(date +%b)
tahun=$(date +%y)
ba=$(curl -s https://pastebin.com/raw/0gWiX6hE)
if [ "$(grep -wc ${bulan} /etc/t1)" != '0' ]; then
bulan=$(date +%b)
month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $6}')
month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $7}')
else
bulan2=$(date +%Y-%m)
month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $5}')
month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $6}')
fi
echo "$month_tx $month_txv" > /etc/usage2
xray2=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray2 == "running" ]]; then
echo -ne
else
systemctl restart xray
systemctl start xray
fi
nginx2=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx2 == "running" ]]; then
echo -ne
else
systemctl restart nginx
systemctl start nginx
fi
cd
if [[ -e /usr/bin/kyt ]]; then
nginx=$( systemctl status kyt | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
echo -ne
else
systemctl restart kyt
systemctl start kyt
fi
kyt=$( systemctl status kyt | grep "TERM" | wc -l )
if [[ $kyt == "0" ]]; then
echo -ne
else
systemctl restart kyt
systemctl start kyt
fi
fi
stunnel=$( systemctl status ws-stunnel | grep "Errno" | wc -l )
if [[ $stunnel == "0" ]]; then
echo -ne
else
systemctl restart ws-stunnel
systemctl start ws-stunnel
fi
stunnel2=$( systemctl status ws-stunnel | grep "TERM" | wc -l )
if [[ $stunnel2 == "0" ]]; then
echo -ne
else
systemctl restart ws-stunnel
systemctl start ws-stunnel
fi
xrray=$( systemctl status xray | grep "error" | wc -l )
if [[ $xrray == "0" ]]; then
echo -ne
else
systemctl restart xray
systemctl start xray
systemctl restart nginx
systemctl start nginx
fi
bash2=$( pgrep bash | wc -l )
if [[ $bash2 -gt "20" ]]; then
killall bash
fi
