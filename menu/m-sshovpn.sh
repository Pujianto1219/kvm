#!/bin/bash
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
colornow=$(cat /etc/rmbl/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/rmbl/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/rmbl/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
ipsaya=$(curl -sS ipv4.icanhazip.com)
ipsa=$(wget -qO- ifconfig.me)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/Pujianto1219/ip/main/ip"
checking_sc() {
useexp=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
if [[ $date_list < $useexp ]]; then
echo -ne
else
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC}          ${WH}• AUTOSCRIPT PREMIUM •                ${NC} $COLOR1│ $NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│            ${RED}PERMISSION DENIED !${NC}                  │"
echo -e "$COLOR1│   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}                             │"
echo -e "$COLOR1│     \033[0;33mBuy access permissions for scripts${NC}          │"
echo -e "$COLOR1│             \033[0;33mContact Your Admin ${NC}                 │"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
exit
fi
}
checking_sc
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
author=$(cat /etc/profil)
TIMES="10"
CHATID=$(cat /etc/per/id)
KEY=$(cat /etc/per/token)
URL="https://api.telegram.org/bot$KEY/sendMessage"
domain=`cat /etc/xray/domain`
CHATID2=$(cat /etc/perlogin/id)
KEY2=$(cat /etc/perlogin/token)
URL2="https://api.telegram.org/bot$KEY2/sendMessage"
cd
if [ ! -e /etc/xray/sshx/akun ]; then
mkdir -p /etc/xray/sshx/akun
fi
function usernew(){
clear
domen=`cat /etc/xray/domain`
sldomain=`cat /etc/xray/dns`
slkey=`cat /etc/slowdns/server.pub`
TIMES="10"
CHATID=$(cat /etc/per/id)
KEY=$(cat /etc/per/token)
URL="https://api.telegram.org/bot$KEY/sendMessage"
CHATID2=$(cat /etc/perlogin/id 2>/dev/null)
KEY2=$(cat /etc/perlogin/token 2>/dev/null)
URL2="https://api.telegram.org/bot$KEY2/sendMessage"
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
author=$(cat /etc/profil)

clear
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC}                ${WH}• SSH PANEL MENU •               ${NC} $COLOR1│ $NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e " "

until [[ $Login =~ ^[a-zA-Z0-9_.-]+$ && ${CLIENT_EXISTS} == '0' ]]; do
read -p "   Username    : " Login
CLIENT_EXISTS=$(grep -w $Login /etc/xray/ssh | wc -l)
if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
echo -e " "
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC}                ${WH}• SSH PANEL MENU •               ${NC} $COLOR1│ $NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e " "
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│                                                 │"
echo -e "$COLOR1│${WH} Nama Duplikat Silahkan Buat Nama Lain.          $COLOR1│"
echo -e "$COLOR1│                                                 │"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
read -n 1 -s -r -p "Press any key to back"
usernew
fi
read -p "   Password    : " Pass
done

until [[ $iplim =~ ^[0-9]+$ ]]; do read -p "   Limit IP    : " iplim; done
until [[ $Quota =~ ^[0-9]+$ ]]; do read -p "   Limit Quota : " Quota; done
until [[ $masaaktif =~ ^[0-9]+$ ]]; do read -p "   Masa Aktif  : " masaaktif; done

if [ ! -e /etc/xray/sshx ]; then
mkdir -p /etc/xray/sshx
fi
if [ -z ${iplim} ]; then
iplim="0"
fi
if [ -z ${Quota} ]; then
Quota="0"
fi

# Konversi Quota ke Bytes
c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))
if [[ ${c} != "0" ]]; then
echo "${d}" >/etc/xray/sshx/${Login}Quota
fi

echo "${iplim}" >/etc/xray/sshx/${Login}IP
IP=$(curl -sS ifconfig.me);

sleep 1
clear
expi=`date -d "$masaaktif days" +"%Y-%m-%d"`
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e "### $Login $expi $Pass" >> /etc/xray/ssh

cat > /home/vps/public_html/ssh-$Login.txt <<-END
_______________________________
Format SSH OVPN Account
_______________________________
Username         : $Login
Password         : $Pass
Masa Aktif       : $masaaktif Days
Expired          : $exp
_______________________________
Host             : $domen
ISP              : $ISP
CITY             : $CITY
Login Limit      : ${iplim} IP
Quota Limit      : ${Quota} GB
Port OpenSSH     : 22
Port Dropbear    : 143, 109
Port SSH WS      : 80, 7788, 8181, 8282
Port SSH SSL WS  : 443
Port SSL/TLS     : 8443, 8880
Port OVPN WS SSL : 2086
Port OVPN SSL    : 990
Port OVPN TCP    : 1194
Port OVPN UDP    : 2200,
BadVPN UDP       : 7100, 7300, 7300
_______________________________
Host Slowdns    : $sldomain
Port Slowdns     : 80, 443, 53
Pub Key          : $slkey
_______________________________
SSH UDP VIRAL : $domen:1-65535@$Login:$Pass
_______________________________
HTTP COSTUM : $domen:80@$Login:$Pass
_______________________________
Payload WS/WSS   :
GET / HTTP/1.1[crlf]Host: [host][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: ws[crlf][crlf]
_______________________________
OpenVPN SSL      : https://$domen:81/ssl.ovpn
OpenVPN TCP      : https://$domen:81/tcp.ovpn
OpenVPN UDP      : https://$domen:81/udp.ovpn
_______________________________
END

# Setting Tampilan Info Limit
if [ "${Quota}" = "0" ] || [ "${Quota}" = "9999" ]; then
    info_quota="Unlimited"
else
    info_quota="${Quota} GB"
fi

if [ "${iplim}" = "0" ] || [ "${iplim}" = "9999" ]; then
    info_ip="Unlimited IP"
else
    info_ip="${iplim} IP"
fi

TEXT="
🧿───────────────────🧿            
        ✨PREMIUM SSH✨
🔹 Informasi Akun Anda
┌─────────────────────
│Username   : <code>$Login</code>
│Password   : <code>$Pass</code>
│Provider   : $ISP
│Country    : $CITY
│Domain     : <code>$domen</code>
│NSDomain   : <code>$sldomain</code>
│Pub Key    : <code>$slkey</code>
│Dropbear   : 109, 143
│SSH WS     : 80, 7788, 8181, 8282
│SSL/TLS    : 443, 8443, 8880
│OpenVPN    : 990, 1194, 2200, 2086
│UDP Custom : 1-65535
│Proxy Squid: 3128
│BadVPN UDP : 7100, 7300
└─────────────────────
🫧HTTP CUSTOM WS
<code>$domen:80@$Login:$Pass</code>
🧿───────────────────🧿
🫧Payload WS/WSS: 
<code>GET / HTTP/1.1[crlf]Host: [host][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: ws[crlf][crlf]</code>
🧿───────────────────🧿
🫧Save Account: 
https://$domen:81/ssh-$Login.txt
🧿───────────────────🧿
🚀IP Limit  : ${info_ip}
🚀Quota     : ${info_quota}
⏳Masa Aktif: $masaaktif Hari
📆Expired On: $exp
🧿───────────────────🧿
♨ᵗᵉʳⁱᵐᵃᵏᵃˢⁱʰ ᵗᵉˡᵃʰ ᵐᵉⁿᵍᵍᵘⁿᵃᵏᵃⁿ ˡᵃʸᵃⁿᵃⁿ ᵏᵃᵐⁱ♨
"

curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null

cd
if [ ! -e /etc/tele ]; then
echo -ne
else
echo "$TEXT" > /etc/notiftele
bash /etc/tele
fi

user2=$(echo "$Login" | cut -c 1-3)
TIME2=$(date +'%Y-%m-%d %H:%M:%S')

TEXT2="
<code>◇━━━━━━━━━━━━━━━━━◇</code>
<b>   PEMBELIAN SSH SUCCES </b>
<code>◇━━━━━━━━━━━━━━━━━◇</code>
<b>DOMAIN  :</b> <code>${domen} </code>
<b>CITY    :</b> <code>$CITY </code>
<b>DATE    :</b> <code>${TIME2} WIB </code>
<b>DETAIL  :</b> <code>Trx SSH </code>
<b>USER    :</b> <code>${user2}xxx </code>
<b>IP      :</b> <code>${info_ip} </code>
<b>QUOTA   :</b> <code>${info_quota} </code>
<b>DURASI  :</b> <code>$masaaktif Hari </code>
<code>◇━━━━━━━━━━━━━━━━━◇</code>
<i>Notif Pembelian Akun Ssh..</i>"

curl -s --max-time $TIMES -d "chat_id=$CHATID2&disable_web_page_preview=1&text=$TEXT2&parse_mode=html" $URL2 >/dev/null

clear
mkdir -p /etc/xray/sshx/akun
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ${NC} ${WH}• Premium SSH Account • ${NC} $COLOR1 $NC" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}Username   ${COLOR1}: ${WH}$Login"  | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}Password   ${COLOR1}: ${WH}$Pass" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}ISP        ${COLOR1}: ${WH}$ISP" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}City       ${COLOR1}: ${WH}$CITY" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}Host       ${COLOR1}: ${WH}$domen" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}Limit IP   ${COLOR1}: ${WH}${info_ip}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}Quota Limit${COLOR1}: ${WH}${info_quota}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ${NC} ${WH}Expired On ${COLOR1}: ${WH}$exp" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}Port OpenSSH  ${COLOR1}: ${WH}22" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}Port Dropbear ${COLOR1}: ${WH}109, 143" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}SSH WS        ${COLOR1}: ${WH}80, 7788, 8181, 8282" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}SSH SSL WS    ${COLOR1}: ${WH}443" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}SSL/TLS       ${COLOR1}: ${WH}8443, 8880" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}Ovpn Ws SSL   ${COLOR1}: ${WH}2086" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}OVPN SSL      ${COLOR1}: ${WH}990" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}OVPN TCP      ${COLOR1}: ${WH}1194" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}OVPN UDP      ${COLOR1}: ${WH}2200" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}BadVPN UDP    ${COLOR1}: ${WH}7100, 7300" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}Host Slowdns  ${COLOR1}: ${WH}$sldomain" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}Port Slowdns  ${COLOR1}: ${WH}80, 443, 53" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}Pub Key       ${COLOR1}: ${WH}$slkey" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}SSH UDP VIRAL ${COLOR1}: ${WH}$domen:1-65535@$Login:$Pass" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}HTTP CUSTOM   ${COLOR1}: ${WH}$domen:80@$Login:$Pass" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ${NC} ${WH}Payload WS/WSS${COLOR1}: ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}GET / HTTP/1.1[crlf]Host: [host][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: ws[crlf][crlf]${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ${NC} ${WH}Format Openclash ${COLOR1}:" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ${NC} ${WH}https://$domen:81/ssh-$Login.txt${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ${NC} ${WH}    $author      " | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo "" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
read -n 1 -s -r -p "Press any key to back on menu"
menu
}
function trial(){
clear
# Memastikan paket 'at' terinstall untuk auto-delete yang bersih
if ! command -v at &> /dev/null; then
    apt-get install at -y >/dev/null 2>&1
    systemctl enable --now atd >/dev/null 2>&1
fi

domen=$(cat /etc/xray/domain)
sldomain=$(cat /etc/xray/dns)
slkey=$(cat /etc/slowdns/server.pub)
TIMES="10"
CHATID=$(cat /etc/per/id)
KEY=$(cat /etc/per/token)
URL="https://api.telegram.org/bot$KEY/sendMessage"
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
author=$(cat /etc/profil)

clear
cd
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            ${WH}• TRIAL SSH Account •              ${NC} $COLOR1│ $NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e ""

until [[ $timer =~ ^[0-9]+$ ]]; do
read -p "  Expired (Minutes) : " timer
done

Login=Trial-`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari=0
Pass=1
iplim=1
Quota=10 # Default Quota Trial 10 GB

if [ ! -e /etc/xray/sshx ]; then
mkdir -p /etc/xray/sshx
fi

# Konversi Quota ke Bytes untuk Limit SSH
c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))
if [[ ${c} != "0" ]]; then
echo "${d}" >/etc/xray/sshx/${Login}Quota
fi
echo "$iplim" > /etc/xray/sshx/${Login}IP

expi=`date -d "$hari days" +"%Y-%m-%d"`
useradd -e `date -d "$hari days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e "### $Login $expi $Pass" >> /etc/xray/ssh

# Membuat File OpenClash/TXT Format
cat > /home/vps/public_html/ssh-$Login.txt <<-END
_______________________________
Format SSH OVPN Account
_______________________________
Username         : $Login
Password         : $Pass
Expired          : $timer Minutes
_______________________________
Host             : $domen
ISP              : $ISP
CITY             : $CITY
Login Limit      : ${iplim} IP
Quota Limit      : ${Quota} GB
Port OpenSSH     : 22
Port Dropbear    : 143, 109
Port SSH WS      : 80, 7788, 8181, 8282
Port SSH SSL WS  : 443
Port SSL/TLS     : 8443, 8880
Port OVPN WS SSL : 2086
Port OVPN SSL    : 990
Port OVPN TCP    : 1194
Port OVPN UDP    : 2200
BadVPN UDP       : 7100, 7300, 7300
_______________________________
Host Slowdns     : $sldomain
Port Slowdns     : 80, 443, 53
Pub Key          : $slkey
_______________________________
SSH UDP VIRAL : $domen:1-65535@$Login:$Pass
_______________________________
HTTP COSTUM : $domen:80@$Login:$Pass
_______________________________
Payload WS/WSS   :
GET / HTTP/1.1[crlf]Host: [host][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: ws[crlf][crlf]
_______________________________
OpenVPN SSL      : https://$domen:81/ssl.ovpn
OpenVPN TCP      : https://$domen:81/tcp.ovpn
OpenVPN UDP      : https://$domen:81/udp.ovpn
_______________________________
END

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# FORMAT NOTIFIKASI TELEGRAM
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TEXT="
🧿───────────────────🧿            
         ✨TRIAL SSH✨
🔹 Informasi Akun Anda
┌─────────────────────
│Username   : <code>$Login</code>
│Password   : <code>$Pass</code>
│Provider   : $ISP
│Country    : $CITY
│Domain     : <code>$domen</code>
│NSDomain   : <code>$sldomain</code>
│Pub Key    : <code>$slkey</code>
│Dropbear   : 109, 143
│SSH WS     : 80, 7788, 8181, 8282
│SSL/TLS    : 443, 8443, 8880
│OpenVPN    : 990, 1194, 2200, 2086
│UDP Custom : 1-65535
│Proxy Squid: 3128
│BadVPN UDP : 7100, 7300
└─────────────────────
🫧HTTP CUSTOM WS
<code>$domen:80@$Login:$Pass</code>
🧿───────────────────🧿
🫧Payload WS/WSS: 
<code>GET / HTTP/1.1[crlf]Host: [host][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: ws[crlf][crlf]</code>
🧿───────────────────🧿
🫧Save Account: 
https://$domen:81/ssh-$Login.txt
🧿───────────────────🧿
🚀IP Limit  : ${iplim} IP
🚀Quota     : ${Quota} GB
⏳Expired In: $timer Menit
🧿───────────────────🧿
♨ᵗᵉʳⁱᵐᵃᵏᵃˢⁱʰ ᵗᵉˡᵃʰ ᵐᵉⁿᵍᵍᵘⁿᵃᵏᵃⁿ ˡᵃʸᵃⁿᵃⁿ ᵏᵃᵐⁱ♨
"

curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
cd

if [ ! -e /etc/tele ]; then
echo -ne
else
echo "$TEXT" > /etc/notiftele
bash /etc/tele
fi

# ==========================================
# PENJADWALAN HAPUS AKUN OTOMATIS (MENGGUNAKAN AT)
# Akan menghapus User, File IP, File Quota, File Txt, dan Record
# ==========================================
echo "userdel -f $Login && rm -f /etc/xray/sshx/${Login}IP && rm -f /etc/xray/sshx/${Login}Quota && rm -f /home/vps/public_html/ssh-$Login.txt && sed -i '/^### $Login/d' /etc/xray/ssh" | at now + $timer minutes &> /dev/null
# ==========================================

clear
mkdir -p /etc/xray/sshx/akun
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ${NC} ${WH}• Trial SSH Premium Account • " | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}Username   ${COLOR1}: ${WH}$Login"  | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}Password   ${COLOR1}: ${WH}$Pass" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}Expired On ${COLOR1}: ${WH}$timer Minutes"  | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}ISP        ${COLOR1}: ${WH}$ISP" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}City       ${COLOR1}: ${WH}$CITY" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}Host       ${COLOR1}: ${WH}$domen" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}Login Limit${COLOR1}: ${WH}${iplim} IP" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}Quota Limit${COLOR1}: ${WH}${Quota} GB" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}OpenSSH    ${COLOR1}: ${WH}22" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}Dropbear   ${COLOR1}: ${WH}109, 143" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}SSH-WS     ${COLOR1}: ${WH}80, 7788, 8181, 8282" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}SSH-SSL-WS ${COLOR1}: ${WH}443" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}SSL/TLS    ${COLOR1}: ${WH}8443,8880" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}Ovpn Ws    ${COLOR1}: ${WH}2086" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}Port TCP   ${COLOR1}: ${WH}1194" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}Port UDP   ${COLOR1}: ${WH}2200,1-65535" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}Port SSL   ${COLOR1}: ${WH}990" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}OVPN TCP   ${COLOR1}: ${WH}https://$domen:81/tcp.ovpn" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}OVPN UDP   ${COLOR1}: ${WH}https://$domen:81/udp.ovpn" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}OVPN SSL   ${COLOR1}: ${WH}https://$domen:81/ssl.ovpn" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}UDPGW      ${COLOR1}: ${WH}7100-7300" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}PORT SLWDNS${COLOR1}: ${WH}80,443,53" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}NAMESERVER ${COLOR1}: ${WH}$sldomain" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}PUB KEY    ${COLOR1}: ${WH}$slkey" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 $NC  ${WH}SSH ${COLOR1}: ${WH}$domen:80@$Login:$Pass" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ${NC}  ${WH}Payload WS/WSS${COLOR1}: ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1${NC}${WH}GET / HTTP/1.1[crlf]Host: [host][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: ws[crlf][crlf]${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ${NC}  ${WH}Save Link Acount    : " | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ${NC}  ${WH}https://$domen:81/ssh-$Login.txt${NC}$COLOR1 $NC" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ${NC}    ${WH}• $author •${NC}                 $COLOR1 $NC" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
echo "" | tee -a /etc/xray/sshx/akun/log-create-${Login}.log
read -n 1 -s -r -p "Press any key to back on menu"
menu
}
function renew(){
clear
TIMES="10"
CHATID=$(cat /etc/per/id)
KEY=$(cat /etc/per/token)
URL="https://api.telegram.org/bot$KEY/sendMessage"
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
domain=$(cat /etc/xray/domain)
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/ssh")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             ${WH}• RENEW USERS •                    │${NC}$COLOR1$NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e " "
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│                                                 │"
echo -e "$COLOR1│${WH} User Tidak Ada!                              $COLOR1   │"
echo -e "$COLOR1│                                                 │"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-sshovpn
fi
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             ${WH}• RENEW USERS •                    │${NC}$COLOR1$NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e " "
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${WH}Silahkan Pilih User Yang Mau di Renew$COLOR1           │"
echo -e "$COLOR1│ ${WH}ketik [0] kembali kemenu$COLOR1                        │"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 2-3 | nl -s ') '
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
if [[ ${CLIENT_NUMBER} == '1' ]]; then
read -rp "Select one client [1]: " CLIENT_NUMBER
else
read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
if [[ ${CLIENT_NUMBER} == '0' ]]; then
m-sshovpn
fi
fi
done
User=$(grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
Pass=$(grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
egrep "^$User" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
read -p "Day Extend : " Days
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $Days))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
passwd -u $User
usermod -e  $exp4 $User
egrep "^$User" /etc/passwd >/dev/null
echo -e "$Pass\n$Pass\n"|passwd $User &> /dev/null
sed -i "s/### $User $exp/### $User $exp4/g" /etc/xray/ssh >/dev/null
clear
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>  SSH RENEW</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domain} </code>
<b>ISP      :</b> <code>$ISP $CITY </code>
<b>USERNAME :</b> <code>$User </code>
<b>EXPIRED  :</b> <code>$exp4 </code>
<code>◇━━━━━━━━━━━━━━◇</code>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
cd
if [ ! -e /etc/tele ]; then
echo -ne
else
echo "$TEXT" > /etc/notiftele
bash /etc/tele
fi
user2=$(echo "$User" | cut -c 1-3)
TIME2=$(date +'%Y-%m-%d %H:%M:%S')
TEXT2="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>   TRANSAKSI SUCCES </b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domain} </code>
<b>ISP      :</b> <code>$CITY </code>
<b>DATE   :</b> <code>${TIME2} WIB</code>
<b>DETAIL   :</b> <code>Trx SSH </code>
<b>USER :</b> <code>${user2}xxx </code>
<b>DURASI  :</b> <code>$Days Hari </code>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Renew Account From Server..</i>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID2&disable_web_page_preview=1&text=$TEXT2&parse_mode=html" $URL2 >/dev/null
clear
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC}              ${WH}• RENEW USERS •                    │${NC}$COLOR1$NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e " "
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│"
echo -e "$COLOR1│ ${WH}Username   : $User"
echo -e "$COLOR1│ ${WH}Days Added : $Days Days"
echo -e "$COLOR1│ ${WH}Expired on : $exp4"
echo -e "$COLOR1│"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
fi
read -n 1 -s -r -p "Press any key to back on menu"
m-sshovpn
}
function hapus(){
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/ssh")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC}              ${WH}• DELETE USERS •                   │${NC}$COLOR1$NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e " "
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│                                                 │"
echo -e "$COLOR1│${WH} User Tidak Ada!                              $COLOR1   │"
echo -e "$COLOR1│                                                 │"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-sshovpn
fi
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC}              ${WH}• DELETE USERS •                   │${NC}$COLOR1$NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e " "
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${WH}Silahkan Pilih User Yang Mau Didelete     $COLOR1      │"
echo -e "$COLOR1│ ${WH}ketik [0] kembali kemenu                     $COLOR1   │"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 2-3 | nl -s ') '
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
if [[ ${CLIENT_NUMBER} == '1' ]]; then
read -rp "Select one client [1]: " CLIENT_NUMBER
else
read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
if [[ ${CLIENT_NUMBER} == '0' ]]; then
m-sshovpn
fi
fi
done
Pengguna=$(grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
Days=$(grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
Pass=$(grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^### $Pengguna $Days $Pass/d" /etc/xray/ssh
rm /home/vps/public_html/ssh-$Pengguna.txt >/dev/null 2>&1
rm /etc/xray/sshx/${Pengguna}IP >/dev/null 2>&1
rm /etc/xray/sshx/${Pengguna}login >/dev/null 2>&1
if getent passwd $Pengguna > /dev/null 2>&1; then
userdel $Pengguna > /dev/null 2>&1
echo -e "User $Pengguna was removed."
else
echo -e "Failure: User $Pengguna Not Exist."
fi
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>  DELETE SSH OVPN</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domain} </code>
<b>ISP      :</b> <code>$ISP $CITY </code>
<b>USERNAME :</b> <code>$Pengguna </code>
<b>EXPIRED  :</b> <code>$Days </code>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Succes Delete This User...</i>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
cd
if [ ! -e /etc/tele ]; then
echo -ne
else
echo "$TEXT" > /etc/notiftele
bash /etc/tele
fi
read -n 1 -s -r -p "Press any key to back on menu"
m-sshovpn
}
function cekconfig(){
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
author=$(cat /etc/profil)
IP=$(curl -sS ifconfig.me);
domen=`cat /etc/xray/domain`
sldomain=`cat /etc/xray/dns`
slkey=`cat /etc/slowdns/server.pub`
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/ssh")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC}              ${WH}• USER CONFIG •                    │${NC}$COLOR1$NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e " "
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│                                                 │"
echo -e "$COLOR1│${WH} User Tidak Ada!                              $COLOR1   │"
echo -e "$COLOR1│                                                 │"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-sshovpn
fi
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC}              ${WH}• USER CONFIG •                    │${NC}$COLOR1$NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e " "
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│ ${WH}Silahkan Pilih User Yang Mau Dicek     $COLOR1         │"
echo -e "$COLOR1│ ${WH}ketik [0] kembali kemenu                     $COLOR1   │"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 2-3 | nl -s ') '
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
if [[ ${CLIENT_NUMBER} == '1' ]]; then
read -rp "Select one client [1]: " CLIENT_NUMBER
else
read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
if [[ ${CLIENT_NUMBER} == '0' ]]; then
m-sshovpn
fi
fi
done
Login=$(grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
cat /etc/xray/sshx/akun/log-create-${Login}.log
cat /etc/xray/sshx/akun/log-create-${Login}.log > /etc/notifakun
sed -i 's/\x1B\[1;37m//g' /etc/notifakun
sed -i 's/\x1B\[0;96m//g' /etc/notifakun
sed -i 's/\x1B\[0m//g' /etc/notifakun
TEXT=$(cat /etc/notifakun)
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
cd
if [ ! -e /etc/tele ]; then
echo -ne
else
echo "$TEXT" > /etc/notiftele
bash /etc/tele
fi
read -n 1 -s -r -p "   Press any key to back on menu"
menu
}
function hapuslama(){
clear
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}                  ${WH}• MEMBER SSH •                 ${NC}$COLOR1$NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e " "
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo "USERNAME          EXP DATE          STATUS"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "LOCKED"
else
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "UNLOCKED"
fi
fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo "Account number: $JUMLAH user"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e " "
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC}${COLBG1}              ${WH}• DELETE USERS •                   ${NC}$COLOR1$NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e " "
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo ""
read -p "Username SSH to Delete : " Pengguna
if getent passwd $Pengguna > /dev/null 2>&1; then
userdel $Pengguna > /dev/null 2>&1
echo -e "User $Pengguna was removed."
else
echo -e "Failure: User $Pengguna Not Exist."
fi
sed -i "/^### $Pengguna/d" /etc/xray/ssh
read -n 1 -s -r -p "Press any key to back on menu"
m-sshovpn
}
function cek(){
    # Pastikan variabel warna didefinisikan jika belum ada di file utama
    # COLOR1='\033[0;34m'
    # NC='\033[0m'
    
    # Variabel Telegram
    CHATID=$(cat /etc/per/id 2>/dev/null)
    KEY=$(cat /etc/per/token 2>/dev/null)
    URL="https://api.telegram.org/bot$KEY/sendMessage"
    
    # File temporary untuk pesan Telegram
    MSG_FILE="/tmp/telegram_msg.txt"
    
    echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
    echo -e "$COLOR1│${NC}               • SSH ACTIVE USERS •              $COLOR1│ $NC"
    echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
    
    rm -rf /tmp/ssh2
    touch /tmp/ssh2 # Buat file kosong agar grep tidak error
    
    # Header untuk pesan Telegram (menggunakan format HTML)
    echo -e "📊 <b>LAPORAN USER AKTIF</b>\n⏱ Waktu: $(date +'%Y-%m-%d %H:%M:%S')\n━━━━━━━━━━━━━━━━━━━━" > $MSG_FILE

    # Deteksi OS Log
    if [ -e "/var/log/auth.log" ]; then
        LOG="/var/log/auth.log"
    elif [ -e "/var/log/secure" ]; then
        LOG="/var/log/secure"
    else
        echo "Error: File log tidak ditemukan!"
        echo "⚠️ Error: File log SSH tidak ditemukan di server." >> $MSG_FILE
        return 1
    fi

    # Ambil list user dari sistem
    mapfile -t username1 < <(grep "/home/" /etc/passwd | cut -d":" -f1)
    
    # -- CEK DROPBEAR --
    grep -i "Password auth succeeded" "$LOG" > /tmp/log-db.txt
    mapfile -t proc < <(ps aux | grep -i dropbear | awk '{print $2}')
    
    for PID in "${proc[@]}"; do
        grep "dropbear\[$PID\]" /tmp/log-db.txt > /tmp/log-db-pid.txt
        NUM=$(wc -l < /tmp/log-db-pid.txt)
        if [ "$NUM" -eq 1 ]; then
            USER=$(awk '{print $10}' /tmp/log-db-pid.txt | sed "s/'//g")
            IP=$(awk '{print $12}' /tmp/log-db-pid.txt)
            TIME=$(date +'%H:%M:%S')
            echo "$USER $TIME : $IP" >> /tmp/ssh2
        fi
    done

    # -- CEK OPENSSH --
    grep -i "Accepted password for" "$LOG" > /tmp/log-db.txt
    mapfile -t data < <(ps aux | grep "\[priv\]" | awk '{print $2}')
    
    for PID in "${data[@]}"; do
        grep "sshd\[$PID\]" /tmp/log-db.txt > /tmp/log-db-pid.txt
        NUM=$(wc -l < /tmp/log-db-pid.txt)
        if [ "$NUM" -eq 1 ]; then
            USER=$(awk '{print $9}' /tmp/log-db-pid.txt)
            IP=$(awk '{print $11}' /tmp/log-db-pid.txt)
            TIME=$(date +'%H:%M:%S')
            echo "$USER $TIME : $IP" >> /tmp/ssh2
        fi
    done

    # -- TAMPILKAN HASIL SSH & SIMPAN KE TELEGRAM --
    echo -e "<b>[ SSH / Dropbear ]</b>" >> $MSG_FILE
    limitip="0"
    ssh_active=0
    
    for user in "${username1[@]}"; do
        # Menggunakan regex "^$user" agar nama user tidak bertabrakan (misal user 'test' dan 'test1')
        sship=$(grep -w "^$user" /tmp/ssh2 | wc -l)
        if [[ "$sship" -gt "$limitip" ]]; then
            
            # --- BAGIAN TAMBAHAN UNTUK MENGAMBIL IP ---
            # Mengambil data IP dari /tmp/ssh2 pada kolom ke-4, lalu membuang IP yang duplikat
            login_ips=$(grep -w "^$user" /tmp/ssh2 | awk '{print $4}' | sort | uniq | xargs | sed 's/ /, /g')
            
            # Tampil di terminal
            echo -e "$COLOR1${NC} USERNAME   : \033[0;33m$user\033[0m"
            echo -e "$COLOR1${NC} Sesi Login : \033[0;33m$sship\033[0m"
            echo -e "$COLOR1${NC} IP Address : \033[0;33m$login_ips\033[0m\n"
            
            # Masuk ke log Telegram dengan tambahan informasi IP
            echo "👤 User: <code>$user</code> | Sesi: $sship | IP: <code>$login_ips</code>" >> $MSG_FILE
            ssh_active=1
        fi
    done

    # Jika tidak ada yang login SSH
    if [ "$ssh_active" -eq 0 ]; then
        echo "<i>Tidak ada user aktif</i>" >> $MSG_FILE
    fi
    echo "━━━━━━━━━━━━━━━━━━━━" >> $MSG_FILE

    # -- TAMPILKAN HASIL OPENVPN & SIMPAN KE TELEGRAM --
    if [ -f "/etc/openvpn/server/openvpn-tcp.log" ]; then
        echo " "
        echo -e "\033[0;33m[ OpenVPN TCP ]\033[0m"
        grep -w "^CLIENT_LIST" /etc/openvpn/server/openvpn-tcp.log | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-tcp.txt
        cat /tmp/vpn-login-tcp.txt
        
        echo -e "<b>[ OpenVPN TCP ]</b>" >> $MSG_FILE
        # Cek apakah file kosong atau tidak
        if [ -s /tmp/vpn-login-tcp.txt ]; then
            cat /tmp/vpn-login-tcp.txt >> $MSG_FILE
        else
            echo "<i>Tidak ada user aktif</i>" >> $MSG_FILE
        fi
    fi
    
    if [ -f "/etc/openvpn/server/openvpn-udp.log" ]; then
        echo " "
        echo -e "\033[0;33m[ OpenVPN UDP ]\033[0m"
        grep -w "^CLIENT_LIST" /etc/openvpn/server/openvpn-udp.log | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-udp.txt
        cat /tmp/vpn-login-udp.txt
        
        echo -e "\n<b>[ OpenVPN UDP ]</b>" >> $MSG_FILE
        if [ -s /tmp/vpn-login-udp.txt ]; then
            cat /tmp/vpn-login-udp.txt >> $MSG_FILE
        else
            echo "<i>Tidak ada user aktif</i>" >> $MSG_FILE
        fi
    fi

    echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
    
    # ==========================================
    # EKSEKUSI KIRIM KE TELEGRAM (SILENT MODE)
    # ==========================================
    if [[ -n "$CHATID" && -n "$KEY" ]]; then
        # Menggunakan --data-urlencode agar karakter spasi dan baris baru (enter) terkirim sempurna
        curl -s -X POST "$URL" \
            -d chat_id="$CHATID" \
            -d parse_mode="HTML" \
            --data-urlencode text@$MSG_FILE > /dev/null 2>&1
    fi
    # ==========================================

    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    
    # Kembali ke menu sebelumnya
    m-sshovpn
}
function limitssh(){
cd
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/ssh")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Limit SSH Account ⇲        ${NC} $COLOR1 $NC"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "You have no existing clients!"
echo ""
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-sshovpn
fi
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Limit SSH Account ⇲        ${NC} $COLOR1 $NC"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "Select the existing client you want to change ip"
echo " ketik [0] kembali kemenu"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 2-3 | nl -s ') '
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
if [[ ${CLIENT_NUMBER} == '1' ]]; then
read -rp "Select one client [1]: " CLIENT_NUMBER
else
read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
if [[ ${CLIENT_NUMBER} == '0' ]]; then
m-sshovpn
fi
fi
done
until [[ $iplim =~ ^[0-9]+$ ]]; do
read -p "Limit User (IP) New: " iplim
done
if [ ! -e /etc/xray/sshx ]; then
mkdir -p /etc/xray/sshx
fi
if [ -z ${iplim} ]; then
iplim="0"
fi
user=$(grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/ssh" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
echo "${iplim}" >/etc/xray/sshx/${user}IP
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>  SSH IP LIMIT</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domain} </code>
<b>ISP      :</b> <code>$ISP $CITY </code>
<b>USERNAME :</b> <code>$user </code>
<b>EXPIRED  :</b> <code>$exp </code>
<b>IP LIMIT NEW :</b> <code>$iplim IP </code>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Succes Change IP LIMIT...</i>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
cd
if [ ! -e /etc/tele ]; then
echo -ne
else
echo "$TEXT" > /etc/notiftele
bash /etc/tele
fi
clear
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo " SSH Account Was Successfully Change Limit IP"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo " Client Name : $user"
echo " Limit IP    : $iplim IP"
echo ""
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-sshovpn
}
clear
function toggle_autokick_ssh() {
clear

# Membuat file script daemon dan service jika belum ada
if [ ! -f "/etc/systemd/system/autokick-ssh.service" ]; then
    # 1. Buat script latar belakang dari kode asli pengguna
    cat > /usr/local/bin/autokick_ssh_daemon << 'EOF'
#!/bin/bash

# Konfigurasi Dasar
LOG="/var/log/auth.log"
[ -e "/var/log/secure" ] && LOG="/var/log/secure"
DIR_CONF="/etc/xray/sshx"
mkdir -p $DIR_CONF

while true; do
    DATE=$(date +'%Y-%m-%d')
    TIME=$(date +'%H:%M:%S')
    CHATID=$(cat /etc/perlogin/id 2>/dev/null)
    KEY=$(cat /etc/perlogin/token 2>/dev/null)
    URL="https://api.telegram.org/bot$KEY/sendMessage"
    domen=$(cat /etc/xray/domain 2>/dev/null)
    ISP=$(cat /etc/xray/isp 2>/dev/null)
    CITY=$(cat /etc/xray/city 2>/dev/null)
    TIMES="10"

    type=$(cat /etc/typessh 2>/dev/null || echo "delete")
    waktulock=$(cat /etc/waktulockssh 2>/dev/null || echo "15")
    limit_notif=$(cat ${DIR_CONF}/notif 2>/dev/null || echo "3")
    sp1_dur=$(cat ${DIR_CONF}/sp1 2>/dev/null || echo "15")
    sp2_dur=$(cat ${DIR_CONF}/sp2 2>/dev/null || echo "30")

    # Ambil daftar user SSH lokal
    mapfile -t users < <(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd)
    
    echo -n > /tmp/ssh_active_log

    # --- PARSING DROPBEAR ---
    grep -i dropbear "$LOG" | grep -i "Password auth succeeded" > /tmp/log-db.txt
    mapfile -t proc_db < <(ps aux | grep -i dropbear | awk '{print $2}')
    for PID in "${proc_db[@]}"; do
        grep "dropbear\[$PID\]" /tmp/log-db.txt > /tmp/log-db-pid.txt
        if [ $(wc -l < /tmp/log-db-pid.txt) -eq 1 ]; then
            USER=$(awk '{print $10}' /tmp/log-db-pid.txt | sed "s/'//g")
            IP=$(awk '{print $12}' /tmp/log-db-pid.txt)
            echo "$USER : $IP" >> /tmp/ssh_active_log
        fi
    done

    # --- PARSING OPENSSH ---
    grep -i sshd "$LOG" | grep -i "Accepted password for" > /tmp/log-sshd.txt
    mapfile -t proc_sshd < <(ps aux | grep "\[priv\]" | awk '{print $2}')
    for PID in "${proc_sshd[@]}"; do
        grep "sshd\[$PID\]" /tmp/log-sshd.txt > /tmp/log-sshd-pid.txt
        if [ $(wc -l < /tmp/log-sshd-pid.txt) -eq 1 ]; then
            USER=$(awk '{print $9}' /tmp/log-sshd-pid.txt)
            IP=$(awk '{print $11}' /tmp/log-sshd-pid.txt)
            echo "$USER : $IP" >> /tmp/ssh_active_log
        fi
    done

    # --- EVALUASI PELANGGARAN ---
    for usr in "${users[@]}"; do
        limitip=$(cat ${DIR_CONF}/${usr}IP 2>/dev/null || echo "0")
        
        # Skip jika limit 0 atau 9999 (Unlimited)
        if [[ "$limitip" -eq 0 ]] || [[ "$limitip" -eq 9999 ]]; then
            continue
        fi

        login_count=$(grep -w "^${usr}" /tmp/ssh_active_log | wc -l)
        
        if [[ ${login_count} -gt ${limitip} ]]; then
            echo "$DATE $TIME - ${usr} - ${login_count}" >> ${DIR_CONF}/${usr}login
            pelanggaran_ke=$(wc -l < ${DIR_CONF}/${usr}login)
            ip_list=$(grep -w "^${usr}" /tmp/ssh_active_log | cut -d ' ' -f 3 | sort -u | nl -s '. ')

            # Hapus log asli agar peringatan tidak berulang tanpa jeda
            sed -i "/${usr}/d" "$LOG"

            # A. KONDISI PERINGATAN
            if [ "$pelanggaran_ke" -lt "$limit_notif" ]; then
                TEXT="
<code>◇━━━━━━━━━━━━━━━━◇</code>
<b> ⚠️ SSH NOTIF MULTI LOGIN</b>
<code>◇━━━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domen}</code>
<b>ISP      :</b> <code>${ISP} ${CITY}</code>
<b>USERNAME :</b> <code>${usr}</code>
<b>LIMIT IP :</b> <code>${limitip} IP</code>
<b>LOGIN IP :</b> <code>${login_count} IP</code>
<b>WARNING  :</b> <code>ke-${pelanggaran_ke} dari ${limit_notif}</code>
<code>◇━━━━━━━━━━━━━━━━◇</code>
<b>DAFTAR IP TERPANTAU :</b>
<code>$ip_list</code>
<code>◇━━━━━━━━━━━━━━━━◇</code>
<i>Peringatan! Tolong patuhi rules...</i>"
                curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
                
                # Hanya putuskan koneksi (kick) tanpa lock/delete
                pkill -u "$usr" sshd
                pkill -u "$usr" dropbear

            # B. KONDISI EKSEKUSI SANKSI FATAL
            elif [ "$pelanggaran_ke" -ge "$limit_notif" ]; then
                exp=$(grep -wE "^### $usr" "/etc/xray/ssh" | cut -d ' ' -f 3 | sort | uniq)
                pass=$(grep -wE "^### $usr" "/etc/xray/ssh" | cut -d ' ' -f 4 | sort | uniq)
                
                # Eksekusi Kick Proses
                pkill -u "$usr" sshd
                pkill -u "$usr" dropbear
                
                # Reset pelanggaran
                rm -rf ${DIR_CONF}/${usr}login

                # --- MODE LOCK ---
                if [ "$type" == "lock" ]; then
                    echo "### $usr $exp $pass" >> ${DIR_CONF}/listlock
                    sed -i "/^### $usr $exp $pass/d" /etc/xray/ssh
                    passwd -l "$usr" &> /dev/null
                    
                    M=$(date -d "$waktulock minutes" +%M); H=$(date -d "$waktulock minutes" +%H)
                    echo "$M $H * * * root passwd -u $usr && echo \"### $usr $exp $pass\" >> /etc/xray/ssh && rm -f /etc/cron.d/ssh_unlock_${usr}" > /etc/cron.d/ssh_unlock_${usr}
                    TINDAKAN="DIKUNCI SEMENTARA ($waktulock Menit)"
                
                # --- MODE DELETE ---
                elif [ "$type" == "delete" ]; then
                    sed -i "/^### $usr $exp $pass/d" /etc/xray/ssh
                    userdel -f "$usr" &> /dev/null
                    rm -f /etc/xray/sshx/${usr}IP
                    rm -f /home/vps/public_html/ssh-${usr}.txt
                    TINDAKAN="DIHAPUS PERMANEN"
                
                # --- MODE SANKSI BERTINGKAT ---
                elif [ "$type" == "bertingkat" ]; then
                    sp_file="${DIR_CONF}/${usr}_sp"
                    current_sp=$(cat "$sp_file" 2>/dev/null || echo "0")
                    new_sp=$((current_sp + 1))
                    echo "$new_sp" > "$sp_file"

                    if [ "$new_sp" -eq 1 ]; then
                        echo "### $usr $exp $pass" >> ${DIR_CONF}/listlock
                        sed -i "/^### $usr $exp $pass/d" /etc/xray/ssh
                        passwd -l "$usr" &> /dev/null
                        M=$(date -d "$sp1_dur minutes" +%M); H=$(date -d "$sp1_dur minutes" +%H)
                        echo "$M $H * * * root passwd -u $usr && echo \"### $usr $exp $pass\" >> /etc/xray/ssh && rm -f /etc/cron.d/ssh_unlock_${usr}" > /etc/cron.d/ssh_unlock_${usr}
                        TINDAKAN="SP-1: KUNCI SEMENTARA ($sp1_dur Menit)"
                    elif [ "$new_sp" -eq 2 ]; then
                        echo "### $usr $exp $pass" >> ${DIR_CONF}/listlock
                        sed -i "/^### $usr $exp $pass/d" /etc/xray/ssh
                        passwd -l "$usr" &> /dev/null
                        M=$(date -d "$sp2_dur minutes" +%M); H=$(date -d "$sp2_dur minutes" +%H)
                        echo "$M $H * * * root passwd -u $usr && echo \"### $usr $exp $pass\" >> /etc/xray/ssh && rm -f /etc/cron.d/ssh_unlock_${usr}" > /etc/cron.d/ssh_unlock_${usr}
                        TINDAKAN="SP-2: KUNCI SEMENTARA ($sp2_dur Menit)"
                    elif [ "$new_sp" -ge 3 ]; then
                        sed -i "/^### $usr $exp $pass/d" /etc/xray/ssh
                        userdel -f "$usr" &> /dev/null
                        rm -f /etc/xray/sshx/${usr}IP
                        rm -f /home/vps/public_html/ssh-${usr}.txt
                        rm -f "$sp_file"
                        TINDAKAN="SP-3: AKUN DIHAPUS PERMANEN"
                    fi
                fi

                TEXT_SANKSI="
<code>◇━━━━━━━━━━━━━━━━◇</code>
<b> 🚨 SANKSI MULTI LOGIN SSH</b>
<code>◇━━━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domen}</code>
<b>ISP      :</b> <code>${ISP} ${CITY}</code>
<b>USERNAME :</b> <code>${usr}</code>
<b>SANKSI   :</b> <b>${TINDAKAN}</b>
<code>◇━━━━━━━━━━━━━━━━◇</code>
<b>IP TERAKHIR :</b>
<code>$ip_list</code>
<code>◇━━━━━━━━━━━━━━━━◇</code>
<i>Sistem memutus akses akun tersebut...</i>"
                curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT_SANKSI&parse_mode=html" $URL >/dev/null
            fi
        fi
    done

    # Jeda 30 detik agar CPU rileks
    sleep 30
done
EOF
    chmod +x /usr/local/bin/autokick_ssh_daemon

    # 2. Buat file systemd service
    cat > /etc/systemd/system/autokick-ssh.service << 'EOF'
[Unit]
Description=Auto Kick Limit IP SSH & Dropbear
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/autokick_ssh_daemon
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF
    systemctl daemon-reload
fi

# Cek Status Service
if systemctl is-active --quiet autokick-ssh; then
    status_service="\033[0;32mON / RUNNING\033[0m "
else
    status_service="\033[0;31mOFF / STOPPED\033[0m"
fi

# Tampilan Menu
echo -e "$COLOR1╭───────────────────────────────────────────╮${NC}"
echo -e "$COLOR1│${NC}         ${WH}• AUTO LIMIT SSH PANEL •${NC}          $COLOR1│${NC}"
echo -e "$COLOR1├───────────────────────────────────────────┤${NC}"
echo -e "$COLOR1│${NC} Status Sistem : $status_service            "
echo -e "$COLOR1├───────────────────────────────────────────┤${NC}"
echo -e "$COLOR1│${NC} ${WH}[1] Turn ON Auto Limit SSH${NC}                $COLOR1│${NC}"
echo -e "$COLOR1│${NC} ${WH}[2] Turn OFF Auto Limit SSH${NC}               $COLOR1│${NC}"
echo -e "$COLOR1│${NC} ${WH}[0] Back to Menu${NC}                          $COLOR1│${NC}"
echo -e "$COLOR1╰───────────────────────────────────────────╯${NC}"
read -p " Select Option : " opt

case $opt in
    1)
        systemctl enable --now autokick-ssh &> /dev/null
        echo -e " Auto Limit SSH berhasil diaktifkan."
        sleep 1
        toggle_autokick_ssh
        ;;
    2)
        systemctl disable --now autokick-ssh &> /dev/null
        echo -e " Auto Limit SSH berhasil dimatikan."
        sleep 1
        toggle_autokick_ssh
        ;;
    0)
        menu
        ;;
    *)
        echo -e " Pilihan tidak valid!"
        sleep 1
        toggle_autokick_ssh
        ;;
esac
}
function listssh(){
    clear
    
    # ---------------------------------------------------------
    # MENGAMBIL STATUS KONFIGURASI SAAT INI
    # ---------------------------------------------------------
    
    # Cek Mode Aktif
    if [ -f /etc/typessh ]; then
        tipe_aktif=$(cat /etc/typessh)
        if [[ "$tipe_aktif" == "lock" ]]; then
            status_mode="\033[0;32mAUTO LOCK\033[0m"
        elif [[ "$tipe_aktif" == "delete" ]]; then
            status_mode="\033[0;31mAUTO DELETE\033[0m"
        elif [[ "$tipe_aktif" == "bertingkat" ]]; then
            status_mode="\033[0;36mSANKSI BERTINGKAT\033[0m"
        else
            status_mode="\033[0;33mBELUM DISET\033[0m"
        fi
    else
        status_mode="\033[0;31mOFF\033[0m"
        tipe_aktif="none"
    fi

    # Cek Limit Notif Multi-Login (Batas IP)
    if [ -f /etc/xray/sshx/notif ]; then
        limit_multi=$(cat /etc/xray/sshx/notif)
    else
        limit_multi="Belum diset"
    fi

    # Cek Interval Scan (Dari Cronjob)
    if [ -f /etc/cron.d/tendang ]; then
        interval_scan=$(awk '{print $1}' /etc/cron.d/tendang | grep -o '[0-9]*' | head -1)
        if [ -z "$interval_scan" ]; then interval_scan="-"; fi
    else
        interval_scan="-"
    fi

    # Cek Parameter Tambahan
    if [ -f /etc/waktulockssh ]; then durasi_lock=$(cat /etc/waktulockssh); else durasi_lock="-"; fi
    if [ -f /etc/xray/sshx/sp1 ]; then dur_sp1=$(cat /etc/xray/sshx/sp1); else dur_sp1="-"; fi
    if [ -f /etc/xray/sshx/sp2 ]; then dur_sp2=$(cat /etc/xray/sshx/sp2); else dur_sp2="-"; fi

    # ---------------------------------------------------------
    # MENAMPILKAN MENU & INFORMASI STATUS
    # ---------------------------------------------------------
    echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
    echo -e "$COLOR1│${NC}             ${WH}• SETTING MULTI LOGIN •             ${NC}$COLOR1│${NC}"
    echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
    echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
    echo -e "$COLOR1│${NC} ${WH}STATUS SAAT INI :${NC}"
    echo -e "$COLOR1│${NC} Mode Aktif    : ${status_mode}"
    echo -e "$COLOR1│${NC} Batas Multi   : ${WH}${limit_multi}x Login Bersamaan${NC}"
    
    if [[ "$tipe_aktif" == "lock" ]]; then
        echo -e "$COLOR1│${NC} Interval Scan : ${WH}${interval_scan} Menit${NC}"
        echo -e "$COLOR1│${NC} Durasi Lock   : ${WH}${durasi_lock} Menit${NC}"
    elif [[ "$tipe_aktif" == "delete" ]]; then
        echo -e "$COLOR1│${NC} Interval Scan : ${WH}${interval_scan} Menit${NC}"
        echo -e "$COLOR1│${NC} Tindakan      : ${WH}Langsung Dihapus${NC}"
    elif [[ "$tipe_aktif" == "bertingkat" ]]; then
        echo -e "$COLOR1│${NC} Interval Scan : ${WH}${interval_scan} Menit${NC}"
        echo -e "$COLOR1│${NC} SP1 (Lock)    : ${WH}${dur_sp1} Menit${NC}"
        echo -e "$COLOR1│${NC} SP2 (Lock)    : ${WH}${dur_sp2} Menit${NC}"
        echo -e "$COLOR1│${NC} SP3 (Banned)  : ${WH}Akun Dihapus Permanen${NC}"
    fi
    echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
    echo -e " "
    echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
    echo -e "$COLOR1│${NC}  [ 1 ]  ${WH}AUTO LOCKED USER SSH${NC}"
    echo -e "$COLOR1│${NC}  [ 2 ]  ${WH}AUTO DELETE USER SSH${NC}"
    echo -e "$COLOR1│${NC}  [ 3 ]  ${WH}SISTEM SANKSI BERTINGKAT (SP1, SP2, SP3)${NC}"
    echo -e "$COLOR1│${NC}  [ 0 ]  ${WH}BACK TO MENU${NC}"
    echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
    
    until [[ $lock =~ ^[0-3]+$ ]]; do
        read -p "   Pilih Opsi [0-3] : " lock
    done

    # ---------------------------------------------------------
    # PROSES EKSEKUSI BERDASARKAN PILIHAN
    # ---------------------------------------------------------
    if [[ $lock == "0" ]]; then
        menu
        
    elif [[ $lock == "1" ]]; then
        clear
        echo "lock" > /etc/typessh
        mkdir -p /etc/xray/sshx
        
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│${NC}             ${WH}• SETUP AUTO LOCK SSH •             ${NC}$COLOR1│${NC}"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        echo -e "$COLOR1│${NC} Tentukan batas IP login bersamaan (Misal: 2)"
        read -rp "│ Batas Login Multi : " -e notif
        echo "$notif" > /etc/xray/sshx/notif
        
        echo -e "$COLOR1│${NC}"
        echo -e "$COLOR1│${NC} Tentukan interval server melakukan *scan*"
        read -rp "│ Waktu Scan (Menit) : " -e notif2
        
        echo "# Autokill" > /etc/cron.d/tendang
        echo "SHELL=/bin/sh" >> /etc/cron.d/tendang
        echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" >> /etc/cron.d/tendang
        echo "*/$notif2 * * * *  root /usr/bin/tendang" >> /etc/cron.d/tendang
        
        echo -e "$COLOR1│${NC}"
        echo -e "$COLOR1│${NC} Tentukan berapa lama akun akan dikunci otomatis"
        read -rp "│ Durasi Penguncian (Menit) : " -e dur_lock
        echo "${dur_lock}" > /etc/waktulockssh
        
        clear
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│${NC}             ${WH}• KONFIGURASI BERHASIL •            ${NC}$COLOR1│${NC}"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        echo -e "$COLOR1│${NC} ${WH}Mode Aktif  : AUTO LOCK${NC}"
        echo -e "$COLOR1│${NC} ${WH}Batas Multi : $notif IP Bersamaan${NC}"
        echo -e "$COLOR1│${NC} ${WH}Interval    : Setiap $notif2 Menit${NC}"
        echo -e "$COLOR1│${NC} ${WH}Durasi Lock : $dur_lock Menit${NC}"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"

    elif [[ $lock == "2" ]]; then
        clear
        echo "delete" > /etc/typessh
        mkdir -p /etc/xray/sshx
        
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│${NC}            ${WH}• SETUP AUTO DELETE SSH •            ${NC}$COLOR1│${NC}"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        echo -e "$COLOR1│${NC} Tentukan batas IP login bersamaan (Misal: 2)"
        read -rp "│ Batas Login Multi : " -e notif
        echo "$notif" > /etc/xray/sshx/notif
        
        echo -e "$COLOR1│${NC}"
        echo -e "$COLOR1│${NC} Tentukan interval waktu server melakukan *scan*"
        read -rp "│ Waktu Scan (Menit) : " -e notif2
        
        echo "# Autokill" > /etc/cron.d/tendang
        echo "SHELL=/bin/sh" >> /etc/cron.d/tendang
        echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" >> /etc/cron.d/tendang
        echo "*/$notif2 * * * *  root /usr/bin/tendang" >> /etc/cron.d/tendang
        
        clear
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│${NC}             ${WH}• KONFIGURASI BERHASIL •            ${NC}$COLOR1│${NC}"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        echo -e "$COLOR1│${NC} ${WH}Mode Aktif  : AUTO DELETE${NC}"
        echo -e "$COLOR1│${NC} ${WH}Batas Multi : $notif IP Bersamaan${NC}"
        echo -e "$COLOR1│${NC} ${WH}Waktu Scan  : Setiap $notif2 Menit${NC}"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"

    elif [[ $lock == "3" ]]; then
        clear
        echo "bertingkat" > /etc/typessh
        mkdir -p /etc/xray/sshx
        
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│${NC}          ${WH}• SETUP SANKSI BERTINGKAT •            ${NC}$COLOR1│${NC}"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        echo -e "$COLOR1│${NC} Tentukan batas IP login bersamaan (Misal: 2)"
        read -rp "│ Batas Login Multi : " -e notif
        echo "$notif" > /etc/xray/sshx/notif
        
        echo -e "$COLOR1│${NC}"
        echo -e "$COLOR1│${NC} Tentukan interval waktu server melakukan *scan*"
        read -rp "│ Waktu Scan (Menit) : " -e notif2
        
        echo "# Autokill" > /etc/cron.d/tendang
        echo "SHELL=/bin/sh" >> /etc/cron.d/tendang
        echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" >> /etc/cron.d/tendang
        echo "*/$notif2 * * * *  root /usr/bin/tendang" >> /etc/cron.d/tendang
        
        echo -e "$COLOR1│${NC}"
        echo -e "$COLOR1│${NC} HUKUMAN SP1: Akun dikunci sementara"
        read -rp "│ Durasi Penguncian SP1 (Menit) : " -e sp1
        echo "$sp1" > /etc/xray/sshx/sp1
        
        echo -e "$COLOR1│${NC}"
        echo -e "$COLOR1│${NC} HUKUMAN SP2: Akun dikunci lebih lama"
        read -rp "│ Durasi Penguncian SP2 (Menit) : " -e sp2
        echo "$sp2" > /etc/xray/sshx/sp2
        
        echo -e "$COLOR1│${NC}"
        echo -e "$COLOR1│${NC} HUKUMAN SP3: Akun Langsung Terhapus (Delete)"
        
        clear
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│${NC}             ${WH}• KONFIGURASI BERHASIL •            ${NC}$COLOR1│${NC}"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        echo -e "$COLOR1│${NC} ${WH}Mode Aktif  : SANKSI BERTINGKAT${NC}"
        echo -e "$COLOR1│${NC} ${WH}Batas Multi : $notif IP Bersamaan${NC}"
        echo -e "$COLOR1│${NC} ${WH}Interval    : Setiap $notif2 Menit${NC}"
        echo -e "$COLOR1│${NC} ${WH}Hukuman SP1 : Lock $sp1 Menit${NC}"
        echo -e "$COLOR1│${NC} ${WH}Hukuman SP2 : Lock $sp2 Menit${NC}"
        echo -e "$COLOR1│${NC} ${WH}Hukuman SP3 : Delete Account${NC}"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
    fi

    echo ""
    read -n 1 -s -r -p "Tekan tombol apa saja untuk kembali ke menu..."
    m-sshovpn
}
function lockssh(){
clear
cd
if [ ! -e /etc/xray/sshx/listlock ]; then
echo "" > /etc/xray/sshx/listlock
fi
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/sshx/listlock")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Unlock SSH Account ⇲       ${NC} $COLOR1 $NC"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "You have no existing user Lock!"
echo ""
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
m-sshovpn
fi
clear
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Unlock SSH Account ⇲       ${NC} $COLOR1 $NC"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo " Select the existing client you want to Unlock"
echo " ketik [0] kembali kemenu"
echo " tulis clear untuk delete semua Akun"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "     No  User      Expired"
grep -E "^### " "/etc/xray/sshx/listlock" | cut -d ' ' -f 2-3 | nl -s ') '
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
if [[ ${CLIENT_NUMBER} == '1' ]]; then
read -rp "Select one client [1]: " CLIENT_NUMBER
else
read -rp "Select one client [1-${NUMBER_OF_CLIENTS}] to Unlock: " CLIENT_NUMBER
if [[ ${CLIENT_NUMBER} == '0' ]]; then
m-sshovpn
fi
if [[ ${CLIENT_NUMBER} == 'clear' ]]; then
rm /etc/xray/sshx/listlock
m-sshovpn
fi
fi
done
user=$(grep -E "^### " "/etc/xray/sshx/listlock" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/sshx/listlock" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
pass=$(grep -E "^### " "/etc/xray/sshx/listlock" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
passwd -u $user &> /dev/null
echo -e "### $Login $exp $Pass" >> /etc/xray/ssh
sed -i "/^### $user $exp $pass/d" /etc/xray/sshx/listlock &> /dev/null
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>  SSH UNLOK </b>
<code>◇━━━━━━━━━━━━━━◇
<b>DOMAIN   :</b> <code>${domain} </code>
<b>ISP      :</b> <code>$ISP $CITY </code>
<b>USERNAME :</b> <code>$user </code>
<b>IP LIMIT  :</b> <code>$iplim IP </code>
<b>EXPIRED  :</b> <code>$exp </code>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Succes Unlock Akun...</i>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
cd
if [ ! -e /etc/tele ]; then
echo -ne
else
echo "$TEXT" > /etc/notiftele
bash /etc/tele
fi
clear
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo " SSH Account Unlock Successfully"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo " Client Name : $user"
echo " Status  : Unlocked"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-sshovpn
}
clear
author=$(cat /etc/profil)
echo -e "$COLOR1╭───────────────────────────────────────────╮${NC}"
echo -e "$COLOR1│${NC}             ${WH}• SSH PANEL MENU •${NC}            $COLOR1│${NC}"
echo -e "$COLOR1├─────────────────────┬─────────────────────┤${NC}"
echo -e "$COLOR1│${NC} ${WH}[01] CREATE ACCOUNT${NC} $COLOR1│${NC} ${WH}[06] CEK CONFIG${NC}     $COLOR1│${NC}"
echo -e "$COLOR1│${NC} ${WH}[02] TRIAL ACCOUNT${NC}  $COLOR1│${NC} ${WH}[07] CHANGE IP LIMIT${NC}$COLOR1│${NC}"
echo -e "$COLOR1│${NC} ${WH}[03] RENEW ACCOUNT${NC}  $COLOR1│${NC} ${WH}[08] SETUP LOGIN${NC}    $COLOR1│${NC}"
echo -e "$COLOR1│${NC} ${WH}[04] DELETE ACCOUNT${NC} $COLOR1│${NC} ${WH}[09] UNLOCK SSH${NC}     $COLOR1│${NC}"
echo -e "$COLOR1│${NC} ${WH}[05] CEK ONLINE${NC}     $COLOR1│${NC} ${WH}[10] KICK MULTILOGIN${NC}$COLOR1│${NC}"
echo -e "$COLOR1├─────────────────────┴─────────────────────┤${NC}"
echo -e "$COLOR1│${NC} ${WH}[00] GO BACK / EXIT MENU${NC}                  $COLOR1│${NC}"
echo -e "$COLOR1╰───────────────────────────────────────────╯${NC}"
echo -e "             ${WH}• $author •${NC}              "
echo -e ""
echo -ne " ${WH}Select menu ${COLOR1}: ${WH}"; read opt

case $opt in
    01 | 1) clear ; usernew ; exit ;;
    02 | 2) clear ; trial ; exit ;;
    03 | 3) clear ; renew ; exit ;;
    04 | 4) clear ; hapus ; exit ;;
    05 | 5) clear ; cek ; exit ;;
    06 | 6) clear ; cekconfig ; exit ;;
    07 | 7) clear ; limitssh ; exit ;;
    08 | 8) clear ; listssh ; exit ;;
    09 | 9) clear ; lockssh ; exit ;;
    10 | 10) clear ; toggle_autokick ; exit ;;
    00 | 0) clear ; menu ; exit ;;
    X  | 0) clear ; m-sshovpn ;;
    x) exit ;;
    *) echo "Anda salah tekan" ; sleep 1 ; m-sshovpn ;;
esac
