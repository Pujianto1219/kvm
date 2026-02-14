#!/bin/bash
###########- COLOR CODE -##############
colornow=$(cat /etc/rmbl/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/rmbl/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/rmbl/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
###########- END COLOR CODE -##########
ipsaya=$(curl -s -4 icanhazip.com)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/Pujianto1219/ip/main/ip"
checking_sc() {
    useexp=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
    if [[ $date_list < $useexp ]]; then
        echo -ne
    else
        systemctl stop nginx
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${NC}${COLBG1}          ${WH}• AUTOSCRIPT PREMIUM •                 ${NC}$COLOR1 │ $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│            ${RED}PERMISSION DENIED !${NC}                  │"
echo -e "$COLOR1│   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}                             │"
echo -e "$COLOR1│     \033[0;33mBuy access permissions for scripts${NC}          │"
echo -e "$COLOR1│             \033[0;33mContact Your Admin ${NC}                 │"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
        exit
    fi
}
checking_sc
function harusadmin(){
clear
author=$(cat /etc/profil)
Isadmin=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $5}')
if [ "$Isadmin" = "ON" ]; then
m-ipku.sh
else
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${NC}${COLBG1}              ${WH} KAMU BUKAN RESELLER               ${NC}$COLOR1 │$NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${NC} ${WH} [INFO] Kamu Bukan Reseller                 $COLOR1"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${NC}             ${WH} VPN  Tunneling${NC}              $COLOR1│$NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
exit
fi
}
cd
rm -rf /root/casper >/dev/null 
MYIP=$(curl -sS ipv4.icanhazip.com)
listuser=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')
superadmin=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $7}')
uu=$(curl -sS https://pastebin.com/raw/BZ9Fcnqf)

APIGIT=$(cat /etc/github/api)
EMAILGIT=$(cat /etc/github/email)
USERGIT=$(cat /etc/github/username)
author=$(cat /etc/profil)

function tambahip2(){
author=$(cat /etc/profil)
superadmin=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $7}')
if [ "$superadmin" = "VIP" ]; then
tambahip
else
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${NC}${COLBG1}            ${WH} KAMU BUKAN SUPER ADMIN              ${NC}$COLOR1 │$NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${NC} ${WH} [INFO] Kamu Bukan Super Admin                 $COLOR1"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${NC}             ${WH} VPN  Tunneling${NC}              $COLOR1│$NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
fi
}
function gantiip2(){
author=$(cat /etc/profil)
superadmin=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $7}')
if [ "$superadmin" = "VIP" ]; then
mkdir /root/rmbl
cd /root/casper/ &> /dev/null
rm -rf .git &> /dev/null
git init &> /dev/null
wget https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip &> /dev/null

data=( `cat /root/rmbl/ip | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "ip" | cut -d ' ' -f 3 | sort | uniq)
u4=$(grep -w "^### $user" "ip" | cut -d ' ' -f 4 | sort | uniq)
u5=$(grep -w "^### $user" "ip" | cut -d ' ' -f 5 | sort | uniq)

d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/### $user $exp $u4 $u5/d" ip &> /dev/null
fi
done
git add ip &> /dev/null
git commit -m remove &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/${USERGIT}/izin_jual.git &> /dev/null
git push -f https://${APIGIT}@github.com/${USERGIT}/izin_jual.git &> /dev/null
else
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${NC}${COLBG1}            ${WH} KAMU BUKAN SUPER ADMIN              ${NC}$COLOR1 │$NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${NC} ${WH} [INFO] Kamu Bukan Super Admin                 $COLOR1"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${NC}             ${WH} VPN  Tunneling${NC}              $COLOR1│$NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
fi
}
function add_ip(){
clear
nama2=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')
author=$(cat /etc/profil)
TIMES="10"
CHATID=$(cat /etc/per/id)
KEY=$(cat /etc/per/token)
URL="https://api.telegram.org/bot$KEY/sendMessage"
superadmin=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $7}')

echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} REGISTER IPVPS               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
cd
rm -rf /root/rmbl >/dev/null 
until [[ $daftar =~ ^[0-9.]+$ ]]; do
read -p "   MASUKKAN IPNYA: " daftar
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1 ${NC}  [INFO] Checking the IPVPS!"
sleep 1
REQIP=$(curl -sS https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip | awk '{print $4}' | grep $daftar)
if [[ $daftar = $REQIP ]]; then
echo -e "$COLOR1 ${NC}  [INFO] VPS IP Already Registered!!"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
cd
rm -rf /root/rmbl >/dev/null 
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
else
echo -e "$COLOR1 ${NC}  [INFO] OK! IP VPS is not Registered!"
echo -e "$COLOR1 ${NC}  [INFO] Lets Register it!"
sleep 3
clear
fi
done
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} REGISTER IPVPS               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
until [[ $client =~ ^[a-zA-Z0-9_]+$ ]]; do
read -p "   User Name  : " client
done
if [ -z $client ]; then
cd
echo -e "$COLOR1 ${NC}  [INFO] Please Input client"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
fi
clear
if [ "$superadmin" = "VIP" ]; then
until [[ $hari =~ ^[0-9]+$ ]]; do
read -p " Expired (days): " hari
done
else
until [[ $hari =~ ^[0-3]+$ ]]; do
read -p " Expired (days) Max 30 Day: " hari
done
if [ -z $hari ]; then
echo -e "$COLOR1 ${NC}   [INFO] Please Input exp date"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
fi
fi
if [ "$superadmin" = "VIP" ]; then
x="ok"

satu="ON"
dua="OFF"
while true $x != "ok"
do

echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1 ${NC}  ${COLOR1}[01]${NC}  ADMIN   ${COLOR1}[02]${NC}  NORMAL"
echo -e "$COLOR1 ${NC}"
echo -ne "   Input your choice : "; read list
echo ""
case "$list" in 
   1) isadmin="$satu";
      read -p "Limit User (IP): " wip;
      break;;
   2) isadmin="$dua";break;;
   esac
done
fi
MYIP=$(curl -sS ipv4.icanhazip.com)
U2=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')
U3=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $3}')
U4=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $4}')
U5=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $5}')
U6=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $6}')

echo "### $client $exp $daftar" >> /etc/regip/ip
exp=$(date -d "$hari days" +"%Y-%m-%d")
hariini=$(date -d "0 days" +"%Y-%m-%d")
git config --global user.email "${EMAILGIT}" &> /dev/null
git config --global user.name "${USERGIT}" &> /dev/null
mkdir /root/rmbl
cd /root/casper/ &> /dev/null
rm -rf .git &> /dev/null
git init &> /dev/null
wget https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip &> /dev/null
ws=1
regip2=$(expr "$U6" - "$ws")
sed -i "s/### $U2 $U3 $U4 $U5 $U6/### $U2 $U3 $U4 $U5 $regip2/g" ip
if [ "$superadmin" = "VIP" ]; then
echo "### $client $exp $daftar $isadmin $wip @$nama2" >> ip
else
echo "### $client $exp $daftar @$nama2" > /list/ip 
fi
cd list
git add ip
git commit -m "register" &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/${USERGIT}/permission &> /dev/null
git push -f https://${APIGIT}@github.com/${USERGIT}/permission &> /dev/null
sleep 1
d1=$(date -d "$exp" +%s)
d2=$(date -d "$hariini" +%s)
certificate=$(( (d1 - d2) / 86400 ))
clear
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} REGISTER IPVPS               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}  Client IP Register Successfully"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1 ${NC}  Client Name   : $client"
if [ "$superadmin" = "VIP" ]; then
echo -e "$COLOR1 ${NC}  Admin Panel   : $isadmin"
echo -e "$COLOR1 ${NC}  JUMLAH IP    : $wip IP"
fi
echo -e "$COLOR1 ${NC}  IP VPS        : $daftar"
echo -e "$COLOR1 ${NC}  Register Date : $hariini"
echo -e "$COLOR1 ${NC}  Expired Date  : $exp"
echo -e "$COLOR1 ${NC}  Durasi Script  : $certificate Days"
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>   INFO REGISTER IP </b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>CLIENT NAME   : ${client}</b>
<b>IP VPS CLIENT  : ${daftar}</b>
<b>REGISTER DATE : ${hariini}</b>
<b>EXPIRED DATE  : ${exp}</b>
<b>DURASI SCRIPT : ${certificate} Days</b>
<b>Succes Create this IP</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Tunggu 5Menit Untuk Server KeRefresh</i>
<b><i>Terima Kasih Sudah Menggunakan Credits By VPN </i></b>
"

curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
cd
rm -rf /root/rmbl >/dev/null 
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
}
function viewapi(){
author=$(cat /etc/profil)
IPVPS=$(curl -s ipinfo.io/ip )
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
nama2=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')
Exp2=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $3}')
job2=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $7}')
ip=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $6}')
sisaip=$(cat /etc/regip/ip | wc -l) 
totalip=$(expr "$ip" - "$sisaip")
if [ "$job2" = "VIP" ]; then
job="VIP SUPER ADMIN"
else
job="VIP ADMIN"
fi
clear
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}             ${WH} INFO PANEL               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}   Nama   : $nama2"
echo -e "$COLOR1 ${NC}   IP     : $IPVPS"
echo -e "$COLOR1 ${NC}   ISP    : $ISP & $CITY"
echo -e "$COLOR1 ${NC}   EXP    : $Exp2"
echo -e "$COLOR1 ${NC}   ROLE   : $job"
echo -e "$COLOR1 ${NC}   SISA IP : $ip"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
}
function genkey(){
clear
nama2=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')
author=$(cat /etc/profil)
TIMES="10"
CHATID=$(cat /etc/per/id)
KEY=$(cat /etc/per/token)
URL="https://api.telegram.org/bot$KEY/sendMessage"
superadmin=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $7}')

echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} GENERATE KEY IPVPS            ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
cd
until [[ $namaclient =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan Nama tanpa spasi : " -e namaclient
done
if [ "$superadmin" = "VIP" ]; then
until [[ $mkey =~ ^[0-9]+$ ]]; do
read -p " Key Create (max 999) : " mkey
done
until [[ $totalkey =~ ^[0-9]+$ ]]; do
read -p " Expired (days) : " totalkey
done
else
until [[ $totalkey =~ ^[0-3]+$ ]]; do
read -p " Expired (days) Max 30 Day: " totalkey
done
fi

if [ "$superadmin" = "VIP" ]; then
x="ok"

satu="ON"
dua=""
while true $x != "ok"
do

echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1 ${NC}  ${COLOR1}[01]${NC}  ADMIN   ${COLOR1}[02]${NC}  NORMAL"
echo -e "$COLOR1 ${NC}"
echo -ne "   Input your choice : "; read list
echo ""
case "$list" in 
   1) isadmin="$satu";
      read -p "Limit User (IP): " wip;
      break;;
   2) isadmin="$dua";break;;
   esac
done
fi


key=$(openssl rand -hex 5)

MYIP=$(curl -sS ipv4.icanhazip.com)
U2=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')
U3=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $3}')
U4=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $4}')
U5=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $5}')
U6=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $6}')

exp=$(date -d "$hari days" +"%Y-%m-%d")
hariini=$(date -d "0 days" +"%Y-%m-%d")
git config --global user.email "${EMAILGIT}" &> /dev/null
git config --global user.name "${USERGIT}" &> /dev/null
mkdir /root/rmbl
cd /root/rmbl/ &> /dev/null
rm -rf .git &> /dev/null
git init &> /dev/null
wget https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip &> /dev/null
ws=1
regip2=$(expr "$U6" - "$ws")
sed -i "s/### $U2 $U3 $U4 $U5 $U6/### $U2 $U3 $U4 $U5 $regip2/g" ip
git add ip
git commit -m register &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/${USERGIT}/izin_jual &> /dev/null
git push -f https://${APIGIT}@github.com/${USERGIT}/izin_jual &> /dev/null
sleep 0.5
rm ip
wget https://raw.githubusercontent.com/${USERGIT}/license/main/key &> /dev/null
if [ "$superadmin" = "VIP" ]; then
x=1
while [ $x -le $mkey ]
do
key2=$(openssl rand -hex 5)
  echo "### $namaclient Key${key2} $totalkey $isadmin $wip" >> key
  echo "### $namaclient Key${key2} $totalkey $isadmin $wip" >> key2
x=$(( $x + 1 ))
done
else
echo "### $U2 Key${key} $totalkey" >> key
fi
rm -rf .git
git init >/dev/null 2>&1
git add key
git commit -m register &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/${USERGIT}/license &> /dev/null
git push -f https://${APIGIT}@github.com/${USERGIT}/license &> /dev/null
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} GENERATE KEY             ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}  Sukses Create Key"
echo -e ""
echo -e "$COLOR1 ${NC} NAME CLIENT : $namaclient"
if [ "$superadmin" = "VIP" ]; then
echo -e "$COLOR1 ${NC}  Key SCRIPT : "
create2=$(cat /root/rmbl/key2 | grep -w "###" | cut -d ' ' -f 3-3)
echo -e "${create2}"
else
echo -e "$COLOR1 ${NC}  Key SCRIPT : Key${key}"
fi
echo -e "$COLOR1 ${NC}  TGL REGIST : $hariini"
echo -e "$COLOR1 ${NC}  Durasi VPS : $totalkey Hari"
echo -e ""
echo -e ""
echo -e "$COLOR1 ${NC}  Silahkan Disave Keynya"
if [ "$superadmin" = "VIP" ]; then
create3=$(cat /root/rmbl/key2 | grep -w "###" | cut -d ' ' -f 3-3)
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>   Info License Key </b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>Nama Client   : $namaclient</b>
<b>KEY SCRIPT  : </b>
<code>${create3}</code>
<b>TGL Register : ${hariini}</b>
<b>DURASI SCRIPT : ${totalkey} Hari</b>
<b>Succes Create This Key</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Tunggu 5Menit Untuk Server KeRefresh</i>
<b><i>Terima Kasih Sudah Menggunakan Credits By VPN </i></b>
"'&reply_markup={"inline_keyboard":[[{"text":"CHANNEL","url":"https://t.me/AimanVpn wa.me/+628981874211"},{"text":"ORDER AUTOSCRIPT","url":"t.me/AimanVpn wa.me/+628981874211"}]]}'
else
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>   Info License Key </b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>Nama Client   : $namaclient</b>
<b>KEY SCRIPT  : </b><code>Key${key}</code>
<b>REGISTER DATE : ${hariini}</b>
<b>DURASI SCRIPT : ${totalkey} Hari</b>
<b>Succes Create This Key</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Tunggu 5Menit Untuk Server KeRefresh</i>
<b><i>Terima Kasih Sudah Menggunakan Credits By VPN </i></b>
"'&reply_markup={"inline_keyboard":[[{"text":"CHANNEL","url":"https://t.me/AimanVpn wa.me/+628981874211"},{"text":"ORDER AUTOSCRIPT","url":"https://t.me/AimanVpn wa.me/+628981874211"}]]}'
fi
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
cd
rm -rf /root/rmbl >/dev/null 
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
}

function delipvps(){
clear
MYIP=$(curl -sS ipv4.icanhazip.com)
listuser=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')
superadmin=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $7}')
uu=$(curl -sS https://pastebin.com/raw/BZ9Fcnqf)

author=$(cat /etc/profil)
TIMES="10"
CHATID=$(cat /etc/per/id)
KEY=$(cat /etc/per/token)
URL="https://api.telegram.org/bot$KEY/sendMessage"
cd
rm -rf /root/rmbl &> /dev/null
git config --global user.email "${EMAILGIT}" &> /dev/null
git config --global user.name "${USERGIT}" &> /dev/null
mkdir /root/rmbl
cd /root/casper/ &> /dev/null
rm -rf .git &> /dev/null
wget https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip &> /dev/null
git init &> /dev/null
##touch ip &> /dev/null
clear

grep -E "$uu$listuser" "ip" >>/root/rmbl/client

if [ "$superadmin" = "VIP" ]; then
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "ip")
else
NUMBER_OF_CLIENTS=$(grep -c -E "^###" "client")
fi
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
  clear
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} DELETE IPVPS               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}   [INFO] You have no existing clients!"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
fi
clear
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} DELETE IPVPS               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
if [ "$superadmin" = "VIP" ]; then
grep -E "^### " "ip" | cut -d ' ' -f 2-4 | nl -s '. '
else
grep -E "^###" "client" | cut -d ' ' -f 2-4 | nl -s '. '
fi
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo ""
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
  if [[ ${CLIENT_NUMBER} == '1' ]]; then
    read -rp " Select one client Ctrl + C Exit [1]: " CLIENT_NUMBER
  else
    read -rp " Select one client or Input [0] to back. [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
  if [[ ${CLIENT_NUMBER} == '0' ]]; then
  cd
    rm -rf /root/rmbl >/dev/null 
	m-ipku.sh
	fi
	fi
	done
if [ "$superadmin" = "VIP" ]; then
name1=$(grep -E "^### " "ip" | cut -d ' ' -f 2 | sed -n "$CLIENT_NUMBER"p) #name
exp=$(grep -E "^### " "ip" | cut -d ' ' -f 3 | sed -n "$CLIENT_NUMBER"p) #exp
ivps1=$(grep -E "^### " "ip" | cut -d ' ' -f 4 | sed -n "$CLIENT_NUMBER"p) #ip
else
name1=$(grep -E "^### " "client" | cut -d ' ' -f 2 | sed -n "$CLIENT_NUMBER"p) #name
exp=$(grep -E "^### " "client" | cut -d ' ' -f 3 | sed -n "$CLIENT_NUMBER"p) #exp
ivps1=$(grep -E "^### " "client" | cut -d ' ' -f 4 | sed -n "$CLIENT_NUMBER"p) #ip
fi
sed -i "/### $name1 $exp $ivps1/d" ip &> /dev/null
hariini2=$(date -d "0 days" +"%Y-%m-%d")
TEXTD="
Name     : $name1
IPVPS    : $ivps1  
Status   : Deleted on  $hariini2
" 
echo "${TEXTD}" >>/root/rmbl/delete_log  &> /dev/null

git add ip
git commit -m remove &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/${USERGIT}/izin_jual.git &> /dev/null
git push -f https://${APIGIT}@github.com/${USERGIT}/izin_jual.git &> /dev/null
clear
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}         ${WH} DELETE IPVPS         ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}  Client IP Deleted Successfully"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1 ${NC}  IP VPS       : $ivps1"
echo -e "$COLOR1 ${NC}  Expired Date : $exp"
echo -e "$COLOR1 ${NC}  Client Name  : $name1"
cd
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>   INFO DELETE IP </b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>CLIENT NAME   : <code>${name1}</code></b>
<b>IP VPS CLIENT  : <code>${ivps1}</code></b>
<b>EXPIRED DATE  : <code>${exp}</code></b>
<b>Succes Delete this IP</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Tunggu 5Menit Untuk Server KeRefresh</i>
<b><i>Terima Kasih Sudah Menggunakan Credits By VPN </i></b>
"

curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
cd
rm -rf /root/casper >/dev/null 
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo ""
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
}
function tambahip(){
clear
MYIP=$(curl -sS ipv4.icanhazip.com)
listuser=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')
superadmin=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $7}')
uu=$(curl -sS https://pastebin.com/raw/BZ9Fcnqf)

author=$(cat /etc/profil)
TIMES="10"
CHATID=$(cat /etc/per/id)
KEY=$(cat /etc/per/token)
URL="https://api.telegram.org/bot$KEY/sendMessage"
cd
rm -rf /root/rmbl &> /dev/null
git config --global user.email "${EMAILGIT}" &> /dev/null
git config --global user.name "${USERGIT}" &> /dev/null
mkdir /root/rmbl
cd /root/rmbl/ &> /dev/null
rm -rf .git &> /dev/null
wget https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip &> /dev/null
git init &> /dev/null
clear
NUMBER_OF_CLIENTS=$(grep -c -E "ON " "bbb")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
  clear
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} TAMBAH LIMIT IPVPS               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}   [INFO] You have no existing clients!"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}" 
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
fi
clear
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} TAMBAH LIMIT IPVPS               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
grep -E "ON " "ip" | cut -d ' ' -f 2-6 | nl -s '. '
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}" 
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
  if [[ ${CLIENT_NUMBER} == '1' ]]; then
    read -rp " Select one client Ctrl + C Exit [1]: " CLIENT_NUMBER
  else
    read -rp " Select one client or Input [0] to back. [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
  if [[ ${CLIENT_NUMBER} == '0' ]]; then 
  cd
    rm -rf /root/rmbl >/dev/null 
	m-ipku.sh
	fi
	fi
	done

name1=$(grep -E "^### " "ip" | cut -d ' ' -f 2 | sed -n "$CLIENT_NUMBER"p) #name
exp=$(grep -E "^### " "ip" | cut -d ' ' -f 3 | sed -n "$CLIENT_NUMBER"p) #exp
ivps1=$(grep -E "^### " "ip" | cut -d ' ' -f 4 | sed -n "$CLIENT_NUMBER"p) #ip
admin=$(grep -E "^### " "ip" | cut -d ' ' -f 5 | sed -n "$CLIENT_NUMBER"p) #iptambah
iptambah=$(grep -E "^### " "ip" | cut -d ' ' -f 6 | sed -n "$CLIENT_NUMBER"p) #iptambah

asd=""
zx="OFF"
if [ "$admin" = "$zx" ]; then
echo -e "BUKAN ADMIN"
tambahip
fi

if [ "$admin" = "$asd" ]; then 
echo -e "BUKAN ADMIN"
tambahip
fi

until [[ $ipbaru =~ ^[0-9]+$ ]]; do
read -rp "   Input Angka Tambahan Limit IPNYA: " ipbaru
done
ipbaru2=$(expr "$iptambah" + "$ipbaru")
sed -i "s/### $name1 $exp $ivps1 $admin $iptambah/### $name1 $exp $ivps1 $admin $ipbaru2/g" ip &> /dev/null
hariini2=$(date -d "0 days" +"%Y-%m-%d")

git add ip
git commit -m remove &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/${USERGIT}/izin_jual.git &> /dev/null
git push -f https://${APIGIT}@github.com/${USERGIT}/izin_jual.git &> /dev/null
clear
echo -e "$COLOR1тФМтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФР${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}         ${WH} TAMBAH IPVPS ADMIN         ${NC} $COLOR1 $NC"
echo -e "$COLOR1тФФтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФШ${NC}"
echo -e "$COLOR1тФМтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФР${NC}"
echo -e "$COLOR1 ${NC}  Client IP Successfully Add"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1 ${NC}  Name Client   : $name1"
echo -e "$COLOR1 ${NC}  IP OLD RESS  : $iptambah IP"
echo -e "$COLOR1 ${NC}  NEW ADD IP  : $ipbaru IP"

TEXT="
<code>тЧЗтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтЧЗ</code>
<b>  ЁЯФ▒ INFO TAMBAH IP RESELLER </b>
<code>тЧЗтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтЧЗ</code>
<b>CLIENT NAME   : <code>${name1} </code></b>
<b>SISA IP  : <code>${iptambah} IP</code></b>
<b>TAMBAHAN IP  : <code>>${ipbaru} IP</code></b>
<b>Succes Tambah IP Reseller</b>
<code>тЧЗтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтЧЗ</code>
<i>Tunggu 5Menit Untuk Server KeRefresh</i>
" 

cd
rm -rf /root/rmbl >/dev/null 
echo -e "$COLOR1тФФтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФШ${NC}" 
echo -e "$COLOR1тФМтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФА ${WH}BY${NC} ${COLOR1}тФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФР${NC}"
echo -e "$COLOR1 ${NC}                ${WH} $author ${NC}                 $COLOR1 $NC"
echo -e "$COLOR1тФФтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФШ${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
}
function gantinama(){
clear
MYIP=$(curl -sS ipv4.icanhazip.com)
listuser=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')
superadmin=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $7}')
uu=$(curl -sS https://pastebin.com/raw/BZ9Fcnqf)

author=$(cat /etc/profil)
TIMES="10"
CHATID=$(cat /etc/per/id)
KEY=$(cat /etc/per/token)
URL="https://api.telegram.org/bot$KEY/sendMessage"
cd
rm -rf /root/casper &> /dev/null
git config --global user.email "${EMAILGIT}" &> /dev/null
git config --global user.name "${USERGIT}" &> /dev/null
mkdir /root/rmbl
cd /root/rmbl/ &> /dev/null
rm -rf .git &> /dev/null
wget https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip &> /dev/null
git init &> /dev/null
#touch ip &> /dev/null
clear
grep -E "$uu$listuser" "ip" >>/root/rmbl/client

if [ "$superadmin" = "VIP" ]; then
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "ip")
else
NUMBER_OF_CLIENTS=$(grep -c -E "^###" "client")
fi

if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
  clear
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} GANTI NAMA IPVPS               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}   [INFO] You have no existing clients!"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}" 
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
fi
clear
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} GANTI NAMA IPVPS               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
if [ "$superadmin" = "VIP" ]; then
grep -E "^### " "ip" | cut -d ' ' -f 2-4 | nl -s '. '
else
grep -E "^###" "client" | cut -d ' ' -f 2-4 | nl -s '. '
fi
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}" 
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
  if [[ ${CLIENT_NUMBER} == '1' ]]; then
    read -rp " Select one client Ctrl + C Exit [1]: " CLIENT_NUMBER
  else
    read -rp " Select one client or Input [0] to back. [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
  if [[ ${CLIENT_NUMBER} == '0' ]]; then
  cd 
    rm -rf /root/rmbl >/dev/null 
	m-ipku.sh
	fi
	fi
	done


read -rp "   Please Input New Name : " namabaru

if [ "$superadmin" = "VIP" ]; then
name1=$(grep -E "^### " "ip" | cut -d ' ' -f 2 | sed -n "$CLIENT_NUMBER"p) #name
exp=$(grep -E "^### " "ip" | cut -d ' ' -f 3 | sed -n "$CLIENT_NUMBER"p) #exp
ivps1=$(grep -E "^### " "ip" | cut -d ' ' -f 4 | sed -n "$CLIENT_NUMBER"p) #ip
else
name1=$(grep -E "^### " "client" | cut -d ' ' -f 2 | sed -n "$CLIENT_NUMBER"p) #name
exp=$(grep -E "^### " "client" | cut -d ' ' -f 3 | sed -n "$CLIENT_NUMBER"p) #exp
ivps1=$(grep -E "^### " "client" | cut -d ' ' -f 4 | sed -n "$CLIENT_NUMBER"p) #ip
fi
sed -i "s/### $name1/### $namabaru/g" ip &> /dev/null
hariini2=$(date -d "0 days" +"%Y-%m-%d")
TEXTD="
Name old     : $namabaru
Name New    : $name1
Status        : succes change
" 
echo "${TEXTD}" >>/root/rmbl/delete_log  &> /dev/null

git add ip
git commit -m remove &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/${USERGIT}/izin_jual.git &> /dev/null
git push -f https://${APIGIT}@github.com/${USERGIT}/izin_jual.git &> /dev/null
clear
echo -e "$COLOR1тФМтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФР${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}         ${WH} GANTI NAMA IPVPS         ${NC} $COLOR1 $NC"
echo -e "$COLOR1тФФтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФШ${NC}"
echo -e "$COLOR1тФМтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФР${NC}"
echo -e "$COLOR1 ${NC}  Client IP Successfully Change"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1 ${NC}  Name old    : $name1"
echo -e "$COLOR1 ${NC}  Name New   : $namabaru"
echo -e "$COLOR1 ${NC}  IPVPS        : $ivps1"
cd
TEXT="
<code>тЧЗтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтЧЗ</code>
<b> ЁЯФ▒ INFO GANTI NAMA IPVPS</b>
<code>тЧЗтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтЧЗ</code>
<b>Name Old   : <code>${name1}</code></b>
<b>New Name  : <code>${namabaru}</code></b>
<b>Succes Change</b>
<code>тЧЗтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтЧЗ</code>
<i>Tunggu 5Menit Untuk Server KeRefresh</i>
"

curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null

cd
rm -rf /root/casper >/dev/null 
echo -e "$COLOR1тФФтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФШ${NC}" 
echo -e "$COLOR1тФМтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФА ${WH}BY${NC} ${COLOR1}тФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФР${NC}"
echo -e "$COLOR1 ${NC}                ${WH} $author ${NC}                 $COLOR1 $NC"
echo -e "$COLOR1тФФтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФШ${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
}
function gantiip(){
clear
MYIP=$(curl -sS ipv4.icanhazip.com)
listuser=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')
superadmin=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $7}')
uu=$(curl -sS https://pastebin.com/raw/BZ9Fcnqf)

author=$(cat /etc/profil)
TIMES="10"
CHATID=$(cat /etc/per/id)
KEY=$(cat /etc/per/token)
URL="https://api.telegram.org/bot$KEY/sendMessage"
cd
rm -rf /root/rmbl &> /dev/null
git config --global user.email "${EMAILGIT}" &> /dev/null
git config --global user.name "${USERGIT}" &> /dev/null
mkdir /root/rmbl >/dev/null
cd /root/rmbl/ &> /dev/null
rm -rf .git &> /dev/null
wget https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip &> /dev/null
git init &> /dev/null
#touch ip &> /dev/null
clear
grep -E "$uu$listuser" "ip" >>/root/rmbl/client

if [ "$superadmin" = "VIP" ]; then
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "ip")
else
NUMBER_OF_CLIENTS=$(grep -c -E "^###" "client")
fi

if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
  clear
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} GANTI USER IPVPS               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}   [INFO] You have no existing clients!"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}" 
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
fi
clear
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} GANTI USER IPVPS               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
if [ "$superadmin" = "VIP" ]; then
grep -E "^### " "ip" | cut -d ' ' -f 2-4 | nl -s '. '
else
grep -E "^###" "client" | cut -d ' ' -f 2-4 | nl -s '. '
fi
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}" 
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
  if [[ ${CLIENT_NUMBER} == '1' ]]; then
    read -rp " Select one client Ctrl + C Exit [1]: " CLIENT_NUMBER
  else
    read -rp " Select one client or Input [0] to back. [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
  if [[ ${CLIENT_NUMBER} == '0' ]]; then
  cd
    rm -rf /root/casper >/dev/null 
	m-ipku.sh
	fi
	fi
	done

read -rp "   Please Input New IP : " ipbaru

if [ "$superadmin" = "VIP" ]; then
name1=$(grep -E "^### " "ip" | cut -d ' ' -f 2 | sed -n "$CLIENT_NUMBER"p) #name
exp=$(grep -E "^### " "ip" | cut -d ' ' -f 3 | sed -n "$CLIENT_NUMBER"p) #exp
ivps1=$(grep -E "^### " "ip" | cut -d ' ' -f 4 | sed -n "$CLIENT_NUMBER"p) #ip
else
name1=$(grep -E "^### " "client" | cut -d ' ' -f 2 | sed -n "$CLIENT_NUMBER"p) #name
exp=$(grep -E "^### " "client" | cut -d ' ' -f 3 | sed -n "$CLIENT_NUMBER"p) #exp
ivps1=$(grep -E "^### " "client" | cut -d ' ' -f 4 | sed -n "$CLIENT_NUMBER"p) #ip
fi
U2=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')
U3=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $3}')
U4=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $4}')
U5=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $5}')
U6=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $6}')
ws=1

regip2=$(expr "$U6" - "$ws")
sed -i "s/### $U2 $U3 $U4 $U5 $U6/### $U2 $U3 $U4 $U5 $regip2/g" ip
sed -i "s/### $name1 $exp $ivps1/### $name1 $exp $ipbaru/g" ip &> /dev/null
hariini2=$(date -d "0 days" +"%Y-%m-%d")
TEXTD="
IPVPS old     : $ivps1
IPVPS New    : $ipbaru
Status        : succes change
" 
echo "${TEXTD}" >>/root/rmbl/delete_log  &> /dev/null

git add ip
git commit -m remove &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/${USERGIT}/permission.git &> /dev/null
git push -f https://${APIGIT}@github.com/${USERGIT}/permission.git &> /dev/null
clear
echo -e "$COLOR1тФМтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФР${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}         ${WH} GANTI IPVPS         ${NC} $COLOR1 $NC"
echo -e "$COLOR1тФФтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФШ${NC}"
echo -e "$COLOR1тФМтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФР${NC}"
echo -e "$COLOR1 ${NC}  Client IP Successfully Change"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1 ${NC}  IP VPS old    : $ivps1"
echo -e "$COLOR1 ${NC}  IP VPS New   : $ipbaru"
echo -e "$COLOR1 ${NC}  Client Name   : $name1"
cd
TEXT="
<code>тЧЗтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтЧЗ</code>
<b> ЁЯФ▒ INFO GANTI IPVPS</b>
<code>тЧЗтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтЧЗ</code>
<b>Client Name   : <code>${name1}</code></b>
<b>IP Lama   : <code>${ivps1}</code></b>
<b>IP Baru  : <code>${ipbaru}</code></b>
<b>Succes Change</b>
<code>тЧЗтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтЧЗ</code>
<i>Tunggu 5Menit Untuk Server KeRefresh</i>
"

curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null

cd
rm -rf /root/casper >/dev/null 
echo -e "$COLOR1тФФтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФШ${NC}" 
echo -e "$COLOR1тФМтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФА ${WH}BY${NC} ${COLOR1}тФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФР${NC}"
echo -e "$COLOR1 ${NC}                ${WH} $author ${NC}                 $COLOR1 $NC"
echo -e "$COLOR1тФФтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФШ${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
}
function renewipvps(){
clear
MYIP=$(curl -sS ipv4.icanhazip.com)
listuser=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')
superadmin=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $7}')
uu=$(curl -sS https://pastebin.com/raw/BZ9Fcnqf)

author=$(cat /etc/profil)
TIMES="10"
CHATID=$(cat /etc/per/id)
KEY=$(cat /etc/per/token)
URL="https://api.telegram.org/bot$KEY/sendMessage"
cd
rm -rf /root/rmbl >/dev/null 
git config --global user.email "${EMAILGIT}" &> /dev/null
git config --global user.name "${USERGIT}" &> /dev/null
mkdir /root/rmbl
cd /root/rmbl
rm -rf .git &> /dev/null
wget https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip &> /dev/null
git init &> /dev/null
#touch ip

clear
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}                ${WH} RENEW IPVPS                 ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
until [[ $iprenew =~ ^[0-9.]+$ ]]; do
read -p "   MASUKKAN IPNYA: " iprenew
REQIP=$(curl -sS https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip | grep $iprenew | awk '{print $4}')
if [[ $iprenew = $REQIP ]]; then
echo -ne
else
echo -e "$COLOR1 ${NC}  [INFO] IP VPS NOT FOUND!"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu" 
m-ipku.sh
fi
done
clear
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}                ${WH} RENEW IPVPS                 ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
until [[ $masaaktif =~ ^[0-3]+$ ]]; do
echo ""
read -p " Expired (days) Max 30 Day: " masaaktif
done
if [ -z $masaaktif ]; then
clear
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} RENEW IPVPS               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}  [INFO] Please Input Correct Number"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}" 
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
fi


name1=$(curl -sS https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip | grep $iprenew | awk '{print $2}') #name
exp=$(curl -sS https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip | grep $iprenew | awk '{print $3}') #exp
ivps1=$(curl -sS https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip | grep $iprenew | awk '{print $4}') #ip
trial=$(curl -sS https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip | grep $iprenew | awk '{print $5}') #ip 
MYIP=$(curl -sS ipv4.icanhazip.com)
UU2=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')

U2=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIPhttps://raw.githubusercontent.com/Pujianto1219/ip/main/ip | awk '{print $2}')
U3=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $3}')
U4=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $4}')
U5=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $5}')
U6=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $6}')


now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(((d1 - d2) / 86400))
exp3=$(($exp2 + $masaaktif))
exp4=$(date -d "$exp3 days" +"%Y-%m-%d")
ws=1
regip2=$(expr "$U6" - "$ws")
sed -i "s/### $U2 $U3 $U4 $U5 $U6/### $U2 $U3 $U4 $U5 $regip2/g" ip

sed -i "s/### $name1 $exp $ivps1 $trial/### $name1 $exp4 $ivps1 @$UU2/g" ip

git add ip
git commit -m renew &> /dev/null 
git branch -M main &> /dev/null
git remote add origin https://github.com/${USERGIT}/izin_jual.git &> /dev/null
git push -f https://${APIGIT}@github.com/${USERGIT}/izin_jual.git &> /dev/null
clear
echo -e "$COLOR1тФМтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФР${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}      ${WH} RENEW IPVPS       ${NC} $COLOR1 $NC"
echo -e "$COLOR1тФФтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФШ${NC}"
echo -e "$COLOR1тФМтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФР${NC}"
echo -e "$COLOR1 ${NC}  Client IP VPS Renew Successfully"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1 ${NC}  IP VPS        : $ivps1"
echo -e "$COLOR1 ${NC}  Renew Date    : $now"
echo -e "$COLOR1 ${NC}  Days Added    : $masaaktif Days"
echo -e "$COLOR1 ${NC}  Expired Date  : $exp4"
echo -e "$COLOR1 ${NC}  Client Name   : $name1"
cd
TEXT="
<code>тЧЗтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтЧЗ</code>
<b> ЁЯФ▒ RENEW IPVPS SCRIPT</b>
<code>тЧЗтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтЧЗ</code>
<b>CLIENT NAME   : <code>${name1}</code></b>
<b>IP VPS CLIENT  : <code>${ivps1}</code></b>
<b>RENEW DATE    : <code>${now}</code></b>
<b>DAYS ADDED    : <code>${masaaktif} Days</code></b>
<b>EXPIRED DATE  : <code>${exp4}</code></b>
<b>Succes Renew This IP</b>
<code>тЧЗтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтФБтЧЗ</code>
<i>Tunggu 5Menit Untuk Server KeRefresh</i>
"

curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
cd
rm -rf /root/casper >/dev/null 
echo -e "$COLOR1тФФтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФШ${NC}" 
echo -e "$COLOR1тФМтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФА ${WH}BY${NC} ${COLOR1}тФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФР${NC}"
echo -e "$COLOR1 ${NC}       ${WH} $author ${NC}         $COLOR1 $NC"
echo -e "$COLOR1тФФтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФАтФШ${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
}

function useripvps(){
clear
MYIP=$(curl -sS ipv4.icanhazip.com)
listuser=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $2}')
superadmin=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $7}')
uu=$(curl -sS https://pastebin.com/raw/BZ9Fcnqf)
author=$(cat /etc/profil)
cd
rm -rf /root/rmbl >/dev/null 
git config --global user.email "${EMAILGIT}"
git config --global user.name "${USERGIT}"
mkdir /root/rmbl
cd /root/rmbl/
rm -rf .git &> /dev/null
wget https://raw.githubusercontent.com/${USERGIT}/izin_jual/main/ip &> /dev/null
git init &> /dev/null
clear
grep -E "$uu$listuser" "ip" >>/root/rmbl/client
grep -E "@trial" "ip" >>/root/rmbl/client
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}               ${WH} LIST IPVPS               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
if [ "$superadmin" = "VIP" ]; then
grep -E "^### " "ip" | cut -d ' ' -f 2-4 | nl -s '. '
else
grep -E "^###" "client" | cut -d ' ' -f 2-4 | nl -s '. '
fi
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}" 
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
cd
rm -rf /root/rmbl >/dev/null 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-ipku.sh
}
Isadmin=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $5}')
ip=$(curl -sS https://raw.githubusercontent.com/Pujianto1219/ip/main/ip | grep $MYIP | awk '{print $6}')
sisaip=$(cat /etc/regip/ip | wc -l) 
ss=0
if [ "$Isadmin" = "OFF" ]; then
clear
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}            ${WH} PREMIUM USER ONLY               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} [INFO] Only PRO Users Can Use This Panel"
echo -e "$COLOR1 ${NC} [INFO] Buy Premium Membership : "
echo -e "$COLOR1 ${NC} [INFO] PM : https://t.me/AimanVpn wa.me/+628981874211"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}" 
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
totalip=$(expr "$ip" - "$sisaip")
if [ $ss -gt $ip ]; then
clear
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}            ${WH} PREMIUM USER ONLY               ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} [INFO] SISA IP REGIST KAMU SUDAH HABIS"
echo -e "$COLOR1 ${NC} [INFO] Buy Premium SUPER ADMIN : "
echo -e "$COLOR1 ${NC} [INFO] PM : https://t.me/AimanVpn wa.me/+628981874211"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}" 
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
if [ $ip = $ss ]; then
clear
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1тФВ${NC}${COLBG1}            ${WH} PREMIUM USER ONLY                 ${NC}$COLOR1тФВ $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} [INFO] SISA IP REGIST KAMU SUDAH HABIS"
echo -e "$COLOR1 ${NC} [INFO] Buy Premium SUPER ADMIN : "
echo -e "$COLOR1 ${NC} [INFO] PM : https://t.me/AimanVpn wa.me/+628981874211"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}" 
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                ${WH} VPN  Tunneling${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
clear
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1тФВ${NC}${COLBG1}            ${WH} PANEL RESELLER IP                 ${NC}$COLOR1тФВ $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}"
echo -e "${COLOR1}╭═══════════════════════════════════════════════════╮${NC}"
echo -e "   $COLOR1 [01]$NC  ${WH}ADD IPVPS      $COLOR1 [05]$NC  ${WH}RENEW IPVPS" 
echo -e "   $COLOR1 [02]$NC  ${WH}KEY GENERATOR$COLOR1   [06]$NC  ${WH}LIST IPVPS"
echo -e "   $COLOR1 [03]$NC  ${WH}DELETE IPVPS   $COLOR1 [07]$NC  ${WH}CHANGE IPVPS"
echo -e "   $COLOR1 [04]$NC  ${WH}CHANGE NAME    $COLOR1 [08]$NC  ${WH}TAMBAH IP [ADMIN]"
echo -e "   "
echo -e "   $COLOR1 [00]$NC  ${WH}GO BACK"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}" 
echo -e "$COLOR1╭═══════════════════ ${WH} SISA IP REG ${NC} ${COLOR1}═════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                    ${WH} $ip ${NC}                 $COLOR1 $NC"
echo -e "$COLOR1╰═══════════════════════════════════════════════════╯${NC}" 
echo -e ""
echo -ne " ${WH}Select menu ${COLOR1}: ${WH}"; read opt
case $opt in
01 | 1) clear ; add_ip ;;
02 | 2) clear ; genkey ;;
03 | 3) clear ; delipvps ;;
04 | 4) clear ; gantinama ;;
05 | 5) clear ; renewipvps ;;
06 | 6) clear ; useripvps ;;
07 | 7) clear ; gantiip;;
08 | 8) clear ; tambahip2 ;;
09 | 9) clear ; gantiip2 ;;
00 | 0) clear ; menu ;;
*) clear ; m-ipku.sh ;;
esac  
