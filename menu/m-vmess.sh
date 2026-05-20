#!/bin/bash
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
colornow=$(cat /etc/rmbl/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/rmbl/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/rmbl/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
ipsaya=$(curl -sS ipv4.icanhazip.com)
ipaya=$(wget -qO- ifconfig.me)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/Pujianto1219/ip/main/ip"
checking_sc() {
useexp=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
if [[ $date_list < $useexp ]]; then
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
exit
fi
}
checking_sc
clear
cd
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
if [ ! -e /etc/vmess/akun ]; then
mkdir -p /etc/vmess/akun
fi
function add-vmess(){
clear
until [[ $user =~ ^[a-zA-Z0-9_.-]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            ${WH}• Add Vmess Account •              ${NC} $COLOR1│ $NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e ""
read -rp "  Username    : " -e user
CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

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

until [[ $iplim =~ ^[0-9]+$ ]]; do read -p "  Limit IP    : " iplim; done
until [[ $Quota =~ ^[0-9]+$ ]]; do read -p "  Limit Quota : " Quota; done
until [[ $masaaktif =~ ^[0-9]+$ ]]; do read -p "  Masa Aktif  : " masaaktif; done

uuid=$(cat /proc/sys/kernel/random/uuid)
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`

if [ ! -e /etc/vmess ]; then
mkdir -p /etc/vmess
fi
if [ ${iplim} = '0' ]; then
iplim="9999"
fi
if [ ${Quota} = '0' ]; then
Quota="9999"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))
if [[ ${c} != "0" ]]; then
echo "${d}" >/etc/vmess/${user}
fi
echo "${iplim}" >/etc/vmess/${user}IP

sed -i '/#vmess$/a\#vm '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\#vmg '"$user $exp $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json

# Pembuatan JSON untuk Base64
VMESS_WS=`cat<<EOF
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
EOF`

VMESS_NON_TLS=`cat<<EOF
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
EOF`

VMESS_GRPC=`cat<<EOF
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
EOF`

VMESS_OPOK=`cat<<EOF
{
"v": "2",
"ps": "${user}",
"add": "${domain}",
"port": "80",
"id": "${uuid}",
"aid": "0",
"net": "ws",
"path": "http://tsel.me/worryfree",
"type": "none",
"host": "tsel.me",
"tls": "none"
}
EOF`

vmesslink1="vmess://$(echo $VMESS_WS | base64 -w 0)"
vmesslink2="vmess://$(echo $VMESS_NON_TLS | base64 -w 0)"
vmesslink3="vmess://$(echo $VMESS_GRPC | base64 -w 0)"
vmesslink4="vmess://$(echo $VMESS_OPOK | base64 -w 0)"

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
Format Vmess WS (CDN) Non TLS Opok TSEL
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
  skip-cert-verify: true
  servername: comunity.instagram.com
  network: ws
  ws-opts:
    path: http://tsel.me/worryfree
    headers:
      Host: ${domain}
_______________________________________________________
Link Vmess Account
_______________________________________________________
Link TLS : ${vmesslink1}
_______________________________________________________
Link NTLS : ${vmesslink2}
_______________________________________________________
Link gRPC : ${vmesslink3}
_______________________________________________________
Link Opok : ${vmesslink4}
_______________________________________________________
END

# Setting Tampilan Info Limit
if [ "${Quota}" = "9999" ]; then
    info_quota="Unlimited"
else
    info_quota="${Quota} GB"
fi

if [ "${iplim}" = "9999" ]; then
    info_ip="Unlimited IP"
else
    info_ip="${iplim} IP"
fi

TEXT="
🧿───────────────────🧿            
       ✨VMESS PREMIUM✨
🔹 Informasi Akun Anda
┌─────────────────────
│Username   : <code>${user}</code>
│Provider   : ${ISP}
│Country    : ${CITY}
│Domain     : <code>${domain}</code>
│Limit IP   : ${info_ip}
│Limit Quota: ${info_quota}
│Masa Aktif : ${masaaktif} Hari
│Expired On : ${exp}
│UUID       : <code>${uuid}</code>
│Port TLS   : 443
│Port NTLS  : 80, 8080
│Port gRPC  : 443
│Security   : auto
│Network    : WS or gRPC
│Path       : <code>/vmess</code>
│Support    : <code>http://bug.com/vmess</code>
│Service    : <code>vmess-grpc</code>
└─────────────────────
🫧Link Vmess TLS:
<code>${vmesslink1}</code>
🧿───────────────────🧿
🫧Link Vmess Non-TLS:
<code>${vmesslink2}</code>
🧿───────────────────🧿
🫧Link Vmess gRPC:
<code>${vmesslink3}</code>
🧿───────────────────🧿
🫧Format OpenClash: 
https://${domain}:81/vmess-${user}.txt
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

user2=$(echo "$user" | cut -c 1-3)
TIME2=$(date +'%Y-%m-%d %H:%M:%S')
TEXT2="
<code>◇━━━━━━━━━━━━━━━━━━━◇</code>
<b>   PEMBELIAN VMESS SUCCES </b>
<code>◇━━━━━━━━━━━━━━━━━━━◇</code>
<b>DOMAIN  :</b> <code>${domain} </code>
<b>CITY    :</b> <code>$CITY </code>
<b>DATE    :</b> <code>${TIME2} WIB </code>
<b>DETAIL  :</b> <code>Trx VMESS </code>
<b>USER    :</b> <code>${user2}xxx </code>
<b>IP      :</b> <code>${info_ip} </code>
<b>QUOTA   :</b> <code>${info_quota} </code>
<b>DURASI  :</b> <code>$masaaktif Hari </code>
<code>◇━━━━━━━━━━━━━━━━━━━◇</code>
<i>Notif Pembelian Akun Vmess..</i>"
curl -s --max-time $TIMES -d "chat_id=$CHATID2&disable_web_page_preview=1&text=$TEXT2&parse_mode=html" $URL2 >/dev/null

clear
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1 ${NC} ${WH}• Premium Vmess Account • ${NC} $COLOR1 $NC" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Username ${COLOR1}: ${WH}${user}" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}ISP  ${COLOR1}: ${WH}$ISP" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}City ${COLOR1}: ${WH}$CITY" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Domain  ${COLOR1}: ${WH}${domain}" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Limit IP${COLOR1}: ${WH}${info_ip}" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Quota Limit  ${COLOR1}: ${WH}${info_quota}" | tee -a /etc/vmess/akun/log-create-${user}.log
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
echo -e "$COLOR1${NC}${WH}Path Support  ${COLOR1}: ${WH}http://bug.com/vmess" | tee -a /etc/vmess/akun/log-create-${user}.log
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
echo -e "$COLOR1 ${NC} ${WH}    $author      " | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
echo "" | tee -a /etc/vmess/akun/log-create-${user}.log

systemctl restart xray > /dev/null 2>&1
echo "---BOT_ACTION_COMPLETE---"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}
function trial-vmess(){
clear
# Memastikan paket 'at' terinstall untuk auto-delete yang bersih
if ! command -v at &> /dev/null; then
    apt-get install at -y >/dev/null 2>&1
    systemctl enable --now atd >/dev/null 2>&1
fi

domain=$(cat /etc/xray/domain)
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
echo -e "$COLOR1│${NC} ${COLBG1}             ${WH}• Trial Vmess Account •             ${NC} $COLOR1│ $NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e ""

until [[ $timer =~ ^[0-9]+$ ]]; do
read -p "  Expired (Minutes) : " timer
done

user=Trial-`</dev/urandom tr -dc X-Z0-9 | head -c4`
iplim=1
Quota=10
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=0

if [ ! -e /etc/vmess ]; then
mkdir -p /etc/vmess
fi

# Konversi Quota ke Bytes
c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))
if [[ ${c} != "0" ]]; then
echo "${d}" >/etc/vmess/${user}
fi
echo "${iplim}" > /etc/vmess/${user}IP
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

# Injeksi config ke Xray
sed -i '/#vmess$/a\#vm '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\#vmg '"$user $exp $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json

# Pembuatan JSON untuk Base64
VMESS_WS=`cat<<EOF
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
EOF`

VMESS_NON_TLS=`cat<<EOF
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
EOF`

VMESS_GRPC=`cat<<EOF
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
EOF`

VMESS_OPOK=`cat<<EOF
{
"v": "2",
"ps": "${user}",
"add": "${domain}",
"port": "80",
"id": "${uuid}",
"aid": "0",
"net": "ws",
"path": "http://tsel.me/worryfree",
"type": "none",
"host": "tsel.me",
"tls": "none"
}
EOF`

vmesslink1="vmess://$(echo $VMESS_WS | base64 -w 0)"
vmesslink2="vmess://$(echo $VMESS_NON_TLS | base64 -w 0)"
vmesslink3="vmess://$(echo $VMESS_GRPC | base64 -w 0)"
vmesslink4="vmess://$(echo $VMESS_OPOK | base64 -w 0)"

# File OpenClash Config
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
Format Vmess WS (CDN) Non TLS Opok TSEL
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
  skip-cert-verify: true
  servername: comunity.instagram.com
  network: ws
  ws-opts:
    path: http://tsel.me/worryfree
    headers:
      Host: ${domain}
_______________________________________________________
Link Vmess Account
_______________________________________________________
Link TLS : ${vmesslink1}
_______________________________________________________
Link NTLS : ${vmesslink2}
_______________________________________________________
Link gRPC : ${vmesslink3}
_______________________________________________________
Link Opok : ${vmesslink4}
_______________________________________________________
END

TEXT="
🧿───────────────────🧿            
        ✨TRIAL VMESS✨
🔹 Informasi Akun Anda
┌─────────────────────
│Username   : <code>${user}</code>
│Provider   : ${ISP}
│Country    : ${CITY}
│Domain     : <code>${domain}</code>
│Limit IP   : ${iplim} IP
│Limit Quota: ${Quota} GB
│Expired In : ${timer} Menit
│UUID       : <code>${uuid}</code>
│Port TLS   : 443
│Port NTLS  : 80, 8080
│Port gRPC  : 443
│Security   : auto
│Network    : WS or gRPC
│Path       : <code>/vmess</code>
│Support    : <code>http://bug.com/vmess</code>
│Service    : <code>vmess-grpc</code>
└─────────────────────
🫧Link Vmess TLS:
<code>${vmesslink1}</code>
🧿───────────────────🧿
🫧Link Vmess Non-TLS:
<code>${vmesslink2}</code>
🧿───────────────────🧿
🫧Link Vmess gRPC:
<code>${vmesslink3}</code>
🧿───────────────────🧿
🫧Format OpenClash: 
https://${domain}:81/vmess-${user}.txt
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
# Akan menghapus inject Config Xray, File IP, File Quota, File Txt, lalu Restart Xray
# ==========================================
echo "sed -i '/^#vm $user $exp/,/^},{/d' /etc/xray/config.json && sed -i '/^#vmg $user $exp $uuid/,/^},{/d' /etc/xray/config.json && rm -f /etc/vmess/${user}IP && rm -f /etc/vmess/${user} && rm -f /home/vps/public_html/vmess-${user}.txt && systemctl restart xray" | at now + $timer minutes &> /dev/null
# ==========================================

clear
mkdir -p /etc/vmess/akun
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1 ${NC} ${WH}• Trial Premium Vmess Account • ${NC} $COLOR1 $NC" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Username   ${COLOR1}: ${WH}${user}" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}ISP        ${COLOR1}: ${WH}$ISP" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}City       ${COLOR1}: ${WH}$CITY" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Domain     ${COLOR1}: ${WH}${domain}" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Limit IP   ${COLOR1}: ${WH}${iplim} IP" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Limit Quota${COLOR1}: ${WH}${Quota} GB" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1 ${NC} ${WH}Expired In ${COLOR1}: ${WH}$timer Minutes" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Port TLS      ${COLOR1}: ${WH}443" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Port NTLS    ${COLOR1}: ${WH}80,8080" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Port gRPC     ${COLOR1}: ${WH}443" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}UUID         ${COLOR1}: ${WH}${uuid}" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}alterId       ${COLOR1}: ${WH}0" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Security      ${COLOR1}: ${WH}auto" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Network       ${COLOR1}: ${WH}ws" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Path          ${COLOR1}: ${WH}/vmess" | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1${NC}${WH}Path Support  ${COLOR1}: ${WH}http://bug.com/vmess" | tee -a /etc/vmess/akun/log-create-${user}.log
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
echo -e "$COLOR1 ${NC} ${WH}    $author      " | tee -a /etc/vmess/akun/log-create-${user}.log
echo -e "$COLOR1 ◇━━━━━━━━━━━━━━━━━◇ ${NC}" | tee -a /etc/vmess/akun/log-create-${user}.log
echo "" | tee -a /etc/vmess/akun/log-create-${user}.log

systemctl restart xray > /dev/null 2>&1
echo "---BOT_ACTION_COMPLETE---"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}
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
m-vmess
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
m-vmess
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
<code>◇━━━━━━━━━━━━━━◇</code>
<b>   XRAY VMESS RENEW</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domain} </code>
<b>ISP      :</b> <code>$ISP $CITY </code>
<b>USERNAME :</b> <code>$user </code>
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
user2=$(echo "$user" | cut -c 1-3)
TIME2=$(date +'%Y-%m-%d %H:%M:%S')
TEXT2="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>   PEMBELIAN VMESS SUCCES </b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domain} </code>
<b>ISP      :</b> <code>$ISP $CITY </code>
<b>DATE   :</b> <code>${TIME2} WIB </code>
<b>DETAIL   :</b> <code>Trx VMESS </code>
<b>USER :</b> <code>${user2}xxx </code>
<b>DURASI  :</b> <code>$masaaktif Hari </code>
<code>◇━━━━━━━━━━━━━━◇</code>
<i> Renew Account From Server..</i>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID2&disable_web_page_preview=1&text=$TEXT2&parse_mode=html" $URL2 >/dev/null
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
m-vmess
}
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
m-vmess
fi
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Limit Vmess Account ⇲      ${NC} $COLOR1 $NC"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo " Select the existing client you want to change ip"
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
m-vmess
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
if [ ! -e /etc/vmess ]; then
mkdir -p /etc/vmess
fi
if [ ${iplim} = '0' ]; then
iplim="9999"
fi
if [ ${Quota} = '0' ]; then
Quota="9999"
fi
user=$(grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
echo "${iplim}" >/etc/vmess/${user}IP
c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))
if [[ ${c} != "0" ]]; then
echo "${d}" >/etc/vmess/${user}
fi
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>  XRAY VMESS IP LIMIT</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domain} </code>
<b>ISP      :</b> <code>$ISP $CITY </code>
<b>USERNAME :</b> <code>$user </code>
<b>IP LIMIT NEW :</b> <code>$iplim IP </code>
<b>QUOTA LIMIT NEW :</b> <code>$Quota GB </code>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Succes Change this Limit...</i>
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
echo " VMESS Account Was Successfully Change Limit IP"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo " Client Name : $user"
echo " Limit IP    : $iplim IP"
echo " Limit Quota : $Quota GB"
echo ""
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vmess
}
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
m-vmess
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
m-vmess
fi
fi
done
user=$(grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
if [ ! -e /etc/vmess/akundelete ]; then
echo "" > /etc/vmess/akundelete
fi
clear
echo "### $user $exp $uuid" >> /etc/vmess/akundelete
sed -i "/^#vmg $user $exp/,/^},{/d" /etc/xray/config.json
sed -i "/^#vm $user $exp/,/^},{/d" /etc/xray/config.json
rm /etc/vmess/${user}IP
clear
rm /home/vps/public_html/vmess-$user.txt >/dev/null 2>&1
rm /etc/vmess/${user}IP >/dev/null 2>&1
rm /etc/vmess/${user}login >/dev/null 2>&1
systemctl restart xray > /dev/null 2>&1
clear
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>  XRAY VMESS DELETE</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domain} </code>
<b>ISP      :</b> <code>$ISP $CITY </code>
<b>USERNAME :</b> <code>$user </code>
<b>EXPIRED :</b> <code>$exp </code>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Succes Delete this Username...</i>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
cd
if [ ! -e /etc/tele ]; then
echo -ne
else
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
m-vmess
}
tim2sec() {
mult=1
arg="$1"
inu=0
while [ ${#arg} -gt 0 ]; do
prev="${arg%:*}"
if [ "$prev" = "$arg" ]; then
curr="${arg#0}"
prev=""
else
curr="${arg##*:}"
curr="${curr#0}"
fi
curr="${curr%.*}"
inu=$((inu + curr * mult))
mult=$((mult * 60))
arg="$prev"
done
echo "$inu"
}
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
function cek-vmess(){
clear
xrayy=$(cat /var/log/xray/access.log | wc -l)
if [[ xrayy -le 5 ]]; then
systemctl restart xray
fi
xraylimit
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            ${WH}• VMESS USER ONLINE •              ${NC} $COLOR1│ $NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═══════════════════════════════════════════════════╮${NC}"
vm=($(cat /etc/xray/config.json | grep "^#vmg" | awk '{print $2}' | sort -u))
echo -n >/tmp/vm
for db1 in ${vm[@]}; do
logvm=$(cat /var/log/xray/access.log | grep -w "email: ${db1}" | tail -n 100)
while read a; do
if [[ -n ${a} ]]; then
set -- ${a}
ina="${7}"
inu="${2}"
anu="${3}"
enu=$(echo "${anu}" | sed 's/tcp://g' | sed '/^$/d' | cut -d. -f1,2,3)
now=$(tim2sec ${timenow})
client=$(tim2sec ${inu})
nowt=$(((${now} - ${client})))
if [[ ${nowt} -lt 40 ]]; then
cat /tmp/vm | grep -w "${ina}" | grep -w "${enu}" >/dev/null
if [[ $? -eq 1 ]]; then
echo "${ina} ${inu} WIB : ${enu}" >>/tmp/vm
splvm=$(cat /tmp/vm)
fi
fi
fi
done <<<"${logvm}"
done
if [[ ${splvm} != "" ]]; then
for vmuser in ${vm[@]}; do
vmhas=$(cat /tmp/vm | grep -w "${vmuser}" | wc -l)
tess=0
if [[ ${vmhas} -gt $tess ]]; then
byt=$(cat /etc/limit/vmess/${vmuser})
gb=$(convert ${byt})
lim=$(cat /etc/vmess/${vmuser})
lim2=$(convert ${lim})
echo -e "$COLOR1${NC} USERNAME : \033[0;33m$vmuser"
echo -e "$COLOR1${NC} IP LOGIN : \033[0;33m$vmhas"
echo -e "$COLOR1${NC} USAGE    : \033[0;33m$gb"
echo -e "$COLOR1${NC} LIMIT    : \033[0;33m$lim2"
echo -e ""
fi
done
fi
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-vmess
}
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
m-vmess
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
m-vmess
fi
fi
done
clear
user=$(grep -E "^#vmg " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
cat /etc/vmess/akun/log-create-${user}.log
cat /etc/vmess/akun/log-create-${user}.log > /etc/notifakun
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
read -n 1 -s -r -p "Press any key to back on menu"
m-vmess
}
clear
function login-vmess(){
    clear
    
    # ---------------------------------------------------------
    # MENGAMBIL STATUS KONFIGURASI SAAT INI (ALL XRAY)
    # ---------------------------------------------------------
    
    # Cek Mode Aktif
    if [ -f /etc/typexray ]; then
        tipe_aktif=$(cat /etc/typexray)
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
    if [ -f /etc/vmess/notif ]; then
        limit_multi=$(cat /etc/vmess/notif)
    else
        limit_multi="Belum diset"
    fi

    # Cek Interval Scan (Dari Cronjob)
    if [ -f /etc/cron.d/xraylimit ]; then
        interval_scan=$(awk '{print $1}' /etc/cron.d/xraylimit | grep -o '[0-9]*' | head -1)
        if [ -z "$interval_scan" ]; then interval_scan="-"; fi
    else
        interval_scan="-"
    fi

    # Cek Parameter Tambahan
    if [ -f /etc/waktulock ]; then durasi_lock=$(cat /etc/waktulock); else durasi_lock="-"; fi
    if [ -f /etc/vmess/sp1 ]; then dur_sp1=$(cat /etc/vmess/sp1); else dur_sp1="-"; fi
    if [ -f /etc/vmess/sp2 ]; then dur_sp2=$(cat /etc/vmess/sp2); else dur_sp2="-"; fi

    # ---------------------------------------------------------
    # MENAMPILKAN MENU & INFORMASI STATUS
    # ---------------------------------------------------------
    echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
    echo -e "$COLOR1│${NC}           ${WH}• SETTING MULTI LOGIN XRAY •          ${NC}$COLOR1│${NC}"
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
    echo -e "$COLOR1│${NC}  [ 1 ]  ${WH}AUTO LOCKED USER XRAY${NC}"
    echo -e "$COLOR1│${NC}  [ 2 ]  ${WH}AUTO DELETE USER XRAY${NC}"
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
        m-vmess
        
    elif [[ $lock == "1" ]]; then
        clear
        echo "lock" > /etc/typexray
        mkdir -p /etc/vless /etc/vmess /etc/trojan
        
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│${NC}            ${WH}• SETUP AUTO LOCK XRAY •             ${NC}$COLOR1│${NC}"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        echo -e "$COLOR1│${NC} Tentukan batas IP login bersamaan (Misal: 2)"
        read -rp "│ Batas Login Multi : " -e notif
        echo "$notif" > /etc/vless/notif
        echo "$notif" > /etc/vmess/notif
        echo "$notif" > /etc/trojan/notif
        
        echo -e "$COLOR1│${NC}"
        echo -e "$COLOR1│${NC} Tentukan interval server melakukan *scan*"
        read -rp "│ Waktu Scan (Menit) : " -e notif2
        
        echo "# Autokill Xray" > /etc/cron.d/xraylimit
        echo "SHELL=/bin/sh" >> /etc/cron.d/xraylimit
        echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" >> /etc/cron.d/xraylimit
        echo "*/$notif2 * * * *  root /usr/bin/xraylimit" >> /etc/cron.d/xraylimit
        
        echo -e "$COLOR1│${NC}"
        echo -e "$COLOR1│${NC} Tentukan berapa lama akun akan dikunci otomatis"
        read -rp "│ Durasi Penguncian (Menit) : " -e dur_lock
        echo "${dur_lock}" > /etc/waktulock
        
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
        echo "delete" > /etc/typexray
        mkdir -p /etc/vless /etc/vmess /etc/trojan
        
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│${NC}           ${WH}• SETUP AUTO DELETE XRAY •            ${NC}$COLOR1│${NC}"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        echo -e "$COLOR1│${NC} Tentukan batas IP login bersamaan (Misal: 2)"
        read -rp "│ Batas Login Multi : " -e notif
        echo "$notif" > /etc/vless/notif
        echo "$notif" > /etc/vmess/notif
        echo "$notif" > /etc/trojan/notif
        
        echo -e "$COLOR1│${NC}"
        echo -e "$COLOR1│${NC} Tentukan interval waktu server melakukan *scan*"
        read -rp "│ Waktu Scan (Menit) : " -e notif2
        
        echo "# Autokill Xray" > /etc/cron.d/xraylimit
        echo "SHELL=/bin/sh" >> /etc/cron.d/xraylimit
        echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" >> /etc/cron.d/xraylimit
        echo "*/$notif2 * * * *  root /usr/bin/xraylimit" >> /etc/cron.d/xraylimit
        
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
        echo "bertingkat" > /etc/typexray
        mkdir -p /etc/vless /etc/vmess /etc/trojan
        
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1│${NC}          ${WH}• SETUP SANKSI BERTINGKAT •            ${NC}$COLOR1│${NC}"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        echo -e "$COLOR1│${NC} Tentukan batas IP login bersamaan (Misal: 2)"
        read -rp "│ Batas Login Multi : " -e notif
        echo "$notif" > /etc/vless/notif
        echo "$notif" > /etc/vmess/notif
        echo "$notif" > /etc/trojan/notif
        
        echo -e "$COLOR1│${NC}"
        echo -e "$COLOR1│${NC} Tentukan interval waktu server melakukan *scan*"
        read -rp "│ Waktu Scan (Menit) : " -e notif2
        
        echo "# Autokill Xray" > /etc/cron.d/xraylimit
        echo "SHELL=/bin/sh" >> /etc/cron.d/xraylimit
        echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" >> /etc/cron.d/xraylimit
        echo "*/$notif2 * * * *  root /usr/bin/xraylimit" >> /etc/cron.d/xraylimit
        
        echo -e "$COLOR1│${NC}"
        echo -e "$COLOR1│${NC} HUKUMAN SP1: Akun dikunci sementara"
        read -rp "│ Durasi Penguncian SP1 (Menit) : " -e sp1
        echo "$sp1" > /etc/vmess/sp1
        echo "$sp1" > /etc/vless/sp1
        echo "$sp1" > /etc/trojan/sp1
        
        echo -e "$COLOR1│${NC}"
        echo -e "$COLOR1│${NC} HUKUMAN SP2: Akun dikunci lebih lama"
        read -rp "│ Durasi Penguncian SP2 (Menit) : " -e sp2
        echo "$sp2" > /etc/vmess/sp2
        echo "$sp2" > /etc/vless/sp2
        echo "$sp2" > /etc/trojan/sp2
        
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
    m-vmess
}
function toggle_autokick_xray() {
clear
# Membuat file script daemon dan service jika belum ada
if [ ! -f "/etc/systemd/system/autokick-xray.service" ]; then
    # 1. Buat script latar belakang dari kode asli pengguna
    cat > /usr/local/bin/autokick_xray_daemon << 'EOF'
#!/bin/bash

# --- FUNGSI BANTUAN ---
tim2sec() {
    mult=1; arg="$1"; inu=0
    while [ ${#arg} -gt 0 ]; do
        prev="${arg%:*}"
        if [ "$prev" = "$arg" ]; then curr="${arg#0}"; prev=""
        else curr="${arg##*:}"; curr="${curr#0}"; fi
        curr="${curr%.*}"
        inu=$((inu + curr * mult))
        mult=$((mult * 60))
        arg="$prev"
    done
    echo "$inu"
}

convert() {
    local -i bytes=$1
    if [[ $bytes -lt 1024 ]]; then echo "${bytes} B"
    elif [[ $bytes -lt 1048576 ]]; then echo "$(((bytes + 1023) / 1024)) KB"
    elif [[ $bytes -lt 1073741824 ]]; then echo "$(((bytes + 1048575) / 1048576)) MB"
    else echo "$(((bytes + 1073741823) / 1073741824)) GB"
    fi
}

# --- CORE FUNCTION: PROSES XRAY ---
process_xray() {
    local protocol=$1
    local tag_id=$2
    local tag_grpc=$3
    local dir_limit="/etc/limit/${protocol}"
    local dir_conf="/etc/${protocol}"
    
    mkdir -p $dir_limit $dir_conf
    
    local type=$(cat /etc/typexray 2>/dev/null || echo "delete")
    local waktulock=$(cat /etc/waktulock 2>/dev/null || echo "15")
    local limit_notif=$(cat ${dir_conf}/notif 2>/dev/null || echo "3")
    local sp1_dur=$(cat ${dir_conf}/sp1 2>/dev/null || echo "15")
    local sp2_dur=$(cat ${dir_conf}/sp2 2>/dev/null || echo "30")

    users=($(grep "^${tag_grpc}" /etc/xray/config.json | awk '{print $2}' | sort -u))
    echo -n > /tmp/${protocol}_log

    # 1. Parsing Log Xray
    for usr in "${users[@]}"; do
        log_data=$(grep -w "email: ${usr}" /var/log/xray/access.log | tail -n 150)
        while read -r line; do
            if [[ -n ${line} ]]; then
                set -- ${line}
                ip_addr="${7}"
                time_log="${2}"
                port_log="${3}"
                port_clean=$(echo "${port_log}" | sed 's/tcp://g' | sed '/^$/d' | cut -d. -f1,2,3)
                
                now=$(tim2sec ${timenow})
                client=$(tim2sec ${time_log})
                diff_sec=$((now - client))
                
                if [[ ${diff_sec} -lt 40 ]]; then
                    if ! grep -w "${ip_addr}" /tmp/${protocol}_log | grep -w "${port_clean}" >/dev/null; then
                        echo "${ip_addr} ${time_log} WIB : ${port_clean}" >> /tmp/${protocol}_log
                    fi
                fi
            fi
        done <<< "${log_data}"
    done

    # 2. Evaluasi Kuota & Multi-Login
    if [[ -s /tmp/${protocol}_log ]]; then
        for usr in "${users[@]}"; do
            # CEK QUOTA VIA XRAY API
            downlink=$(xray api stats --server=127.0.0.1:10085 -name "user>>>${usr}>>>traffic>>>downlink" | grep -w "value" | awk '{print $2}' | cut -d '"' -f2)
            if [ -n "$downlink" ]; then
                current_usage=$(cat ${dir_limit}/${usr} 2>/dev/null || echo "0")
                new_usage=$((current_usage + downlink))
                echo "${new_usage}" > ${dir_limit}/${usr}
                xray api stats --server=127.0.0.1:10085 -name "user>>>${usr}>>>traffic>>>downlink" -reset > /dev/null 2>&1
            fi
            
            limit_quota=$(cat ${dir_conf}/${usr} 2>/dev/null || echo "999999999999")
            usage_quota=$(cat ${dir_limit}/${usr} 2>/dev/null || echo "0")
            
            if [ "$usage_quota" -gt "$limit_quota" ]; then
                exp=$(grep -wE "^${tag_grpc} $usr" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
                uuid=$(grep -wE "^${tag_grpc} $usr" "/etc/xray/config.json" | cut -d ' ' -f 4 | sort | uniq)
                echo "### $usr $exp $uuid" >> ${dir_conf}/userQuota
                sed -i "/^${tag_grpc} $usr $exp/,/^},{/d" /etc/xray/config.json
                sed -i "/^${tag_id} $usr $exp/,/^},{/d" /etc/xray/config.json
                rm -f ${dir_limit}/${usr}
                RESTART_XRAY=1
                continue 
            fi

            # CEK MULTI LOGIN IP
            login_count=$(grep -w "${usr}" /tmp/${protocol}_log | wc -l)
            ip_limit=$(cat ${dir_conf}/${usr}IP 2>/dev/null || echo "0")
            
            if [[ ${login_count} -gt ${ip_limit} && ${ip_limit} -ne 0 ]]; then
                echo "$usr ${login_count}" >> ${dir_conf}/${usr}login
                pelanggaran_ke=$(wc -l < ${dir_conf}/${usr}login)
                ip_list=$(grep -w "${usr}" /tmp/${protocol}_log | cut -d ' ' -f 2-8 | nl -s '. ')

                sed -i "/${usr}/d" /var/log/xray/access.log

                if [ "$pelanggaran_ke" -lt "$limit_notif" ]; then
                    TEXT="
🧿───────────────────🧿            
            ⚠️ PERINGATAN MULTI LOGIN ⚠️
🔹 Informasi Pelanggaran
┌─────────────────────
│Protocol   : <b>${protocol^^}</b>
│Username   : <code>${usr}</code>
│Limit IP   : $ip_limit IP
│Login IP   : ${login_count} IP
│Peringatan : ke-$pelanggaran_ke dari $limit_notif
└─────────────────────
🫧IP Terpantau:
<code>$ip_list</code>
🧿───────────────────🧿
♨ Harap patuhi aturan server ♨"
                    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
                
                elif [ "$pelanggaran_ke" -ge "$limit_notif" ]; then
                    exp=$(grep -wE "^${tag_grpc} $usr" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
                    uuid=$(grep -wE "^${tag_grpc} $usr" "/etc/xray/config.json" | cut -d ' ' -f 4 | sort | uniq)

                    if [ "$type" == "lock" ]; then
                        echo "### $usr $exp $uuid" >> ${dir_conf}/listlock
                        sed -i "/^${tag_grpc} $usr $exp/,/^},{/d" /etc/xray/config.json
                        sed -i "/^${tag_id} $usr $exp/,/^},{/d" /etc/xray/config.json
                        M=$(date -d "$waktulock minutes" +%M); H=$(date -d "$waktulock minutes" +%H)
                        echo "$M $H * * * root /usr/bin/xray $protocol $usr $uuid $exp && rm -f /etc/cron.d/xray_${protocol}_${usr}" > /etc/cron.d/xray_${protocol}_${usr}
                        TINDAKAN="DIKUNCI SEMENTARA ($waktulock Menit)"
                    
                    elif [ "$type" == "delete" ]; then
                        sed -i "/^${tag_grpc} $usr $exp/,/^},{/d" /etc/xray/config.json
                        sed -i "/^${tag_id} $usr $exp/,/^},{/d" /etc/xray/config.json
                        TINDAKAN="DIHAPUS PERMANEN"
                    
                    elif [ "$type" == "bertingkat" ]; then
                        sp_file="${dir_conf}/${usr}_sp"
                        current_sp=$(cat "$sp_file" 2>/dev/null || echo "0")
                        new_sp=$((current_sp + 1))
                        echo "$new_sp" > "$sp_file"

                        if [ "$new_sp" -eq 1 ]; then
                            echo "### $usr $exp $uuid" >> ${dir_conf}/listlock
                            sed -i "/^${tag_grpc} $usr $exp/,/^},{/d" /etc/xray/config.json
                            sed -i "/^${tag_id} $usr $exp/,/^},{/d" /etc/xray/config.json
                            M=$(date -d "$sp1_dur minutes" +%M); H=$(date -d "$sp1_dur minutes" +%H)
                            echo "$M $H * * * root /usr/bin/xray $protocol $usr $uuid $exp && rm -f /etc/cron.d/xray_${protocol}_${usr}" > /etc/cron.d/xray_${protocol}_${usr}
                            TINDAKAN="SP-1: KUNCI SEMENTARA ($sp1_dur Menit)"
                        elif [ "$new_sp" -eq 2 ]; then
                            echo "### $usr $exp $uuid" >> ${dir_conf}/listlock
                            sed -i "/^${tag_grpc} $usr $exp/,/^},{/d" /etc/xray/config.json
                            sed -i "/^${tag_id} $usr $exp/,/^},{/d" /etc/xray/config.json
                            M=$(date -d "$sp2_dur minutes" +%M); H=$(date -d "$sp2_dur minutes" +%H)
                            echo "$M $H * * * root /usr/bin/xray $protocol $usr $uuid $exp && rm -f /etc/cron.d/xray_${protocol}_${usr}" > /etc/cron.d/xray_${protocol}_${usr}
                            TINDAKAN="SP-2: KUNCI SEMENTARA ($sp2_dur Menit)"
                        elif [ "$new_sp" -ge 3 ]; then
                            sed -i "/^${tag_grpc} $usr $exp/,/^},{/d" /etc/xray/config.json
                            sed -i "/^${tag_id} $usr $exp/,/^},{/d" /etc/xray/config.json
                            rm -f "$sp_file"
                            TINDAKAN="SP-3: AKUN DIHAPUS PERMANEN"
                        fi
                    fi

                    TEXT_SANKSI="
🧿───────────────────🧿            
            🚨 PELANGGARAN FATAL 🚨
🔹 Tindakan Otomatis Diterapkan
┌─────────────────────
│Protocol   : <b>${protocol^^}</b>
│Username   : <code>${usr}</code>
│Provider   : $ISP
│Limit IP   : $ip_limit IP
│Login IP   : ${login_count} IP
│Sanksi     : <b>$TINDAKAN</b>
└─────────────────────
🫧IP Terakhir yang terpantau:
<code>$ip_list</code>
🧿───────────────────🧿
♨ Sistem memutus akses akun tersebut ♨"
                    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT_SANKSI&parse_mode=html" $URL >/dev/null
                    rm -rf ${dir_conf}/${usr}login
                    RESTART_XRAY=1
                fi
            fi
        done
    fi
}

# --- MAIN LOOP DAEMON ---
while true; do
    RESTART_XRAY=0
    timenow=$(date +%T" WIB")
    CHATID=$(cat /etc/perlogin/id 2>/dev/null)
    KEY=$(cat /etc/perlogin/token 2>/dev/null)
    URL="https://api.telegram.org/bot$KEY/sendMessage"
    ISP=$(cat /etc/xray/isp 2>/dev/null)
    TIMES="10"

    process_xray "vmess" "#vm" "#vmg"
    process_xray "vless" "#vl" "#vlg"
    process_xray "trojan" "#tr" "#trg"

    if [[ "$RESTART_XRAY" -eq 1 ]]; then
        systemctl restart xray >/dev/null 2>&1
    fi

    # Loop setiap 30 detik
    sleep 30
done
EOF
    chmod +x /usr/local/bin/autokick_xray_daemon

    # 2. Buat file systemd service
    cat > /etc/systemd/system/autokick-xray.service << 'EOF'
[Unit]
Description=Auto Kick Limit IP & Quota All Xray
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/autokick_xray_daemon
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF
    systemctl daemon-reload
fi

# Cek Status Service Aktif atau Tidak
if systemctl is-active --quiet autokick-xray; then
    status_service="\033[0;32mON / RUNNING\033[0m "
else
    status_service="\033[0;31mOFF / STOPPED\033[0m"
fi

# Tampilan Menu Control
echo -e "$COLOR1╭───────────────────────────────────────────╮${NC}"
echo -e "$COLOR1│${NC}     ${WH}• AUTO LIMIT XRAY (ALL PROTOCOL) •${NC}    $COLOR1│${NC}"
echo -e "$COLOR1├───────────────────────────────────────────┤${NC}"
echo -e "$COLOR1│${NC} Status Sistem : $status_service            "
echo -e "$COLOR1├───────────────────────────────────────────┤${NC}"
echo -e "$COLOR1│${NC} ${WH}[1] Turn ON Auto Limit Xray${NC}               $COLOR1│${NC}"
echo -e "$COLOR1│${NC} ${WH}[2] Turn OFF Auto Limit Xray${NC}              $COLOR1│${NC}"
echo -e "$COLOR1│${NC} ${WH}[0] Back to Menu${NC}                          $COLOR1│${NC}"
echo -e "$COLOR1╰───────────────────────────────────────────╯${NC}"
read -p " Select Option : " opt

case $opt in
    1)
        systemctl enable --now autokick-xray &> /dev/null
        echo -e " Auto Limit Xray berhasil diaktifkan."
        sleep 1
        toggle_autokick_xray
        ;;
    2)
        systemctl disable --now autokick-xray &> /dev/null
        echo -e " Auto Limit Xray berhasil dimatikan."
        sleep 1
        toggle_autokick_xray
        ;;
    0)
        menu
        ;;
    *)
        echo -e " Pilihan tidak valid!"
        sleep 1
        toggle_autokick_xray
        ;;
esac
}
function lock-vmess(){
clear
cd
if [ ! -e /etc/vmess/listlock ]; then
echo "" > /etc/vmess/listlock
fi
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/vmess/listlock")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Unlock Vmess Account ⇲     ${NC} $COLOR1 $NC"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "You have no existing user Lock!"
echo ""
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
m-vmess
fi
clear
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Unlock Vmess Account ⇲     ${NC} $COLOR1 $NC"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo " Select the existing client you want to Unlock"
echo " ketik [0] kembali kemenu"
echo " ketik [999] untuk delete semua Akun"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "     No  User   Expired"
grep -E "^### " "/etc/vmess/listlock" | cut -d ' ' -f 2-3 | nl -s ') '
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
if [[ ${CLIENT_NUMBER} == '1' ]]; then
read -rp "Select one client [1]: " CLIENT_NUMBER
else
read -rp "Select one client [1-${NUMBER_OF_CLIENTS}] to Unlock: " CLIENT_NUMBER
if [[ ${CLIENT_NUMBER} == '0' ]]; then
m-vmess
fi
if [[ ${CLIENT_NUMBER} == '999' ]]; then
rm /etc/vmess/listlock
m-vmess
fi
fi
done
user=$(grep -E "^### " "/etc/vmess/listlock" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/vmess/listlock" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^### " "/etc/vmess/listlock" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
sed -i '/#vmess$/a\#vm '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\#vmg '"$user $exp $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
sed -i "/^### $user $exp $uuid/d" /etc/vmess/listlock
systemctl restart xray
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>  XRAY VMESS UNLOCKED</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domain} </code>
<b>ISP      :</b> <code>$ISP $CITY </code>
<b>USERNAME :</b> <code>$user </code>
<b>EXPIRED  :</b> <code>$exp </code>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Succes Unlocked This Akun...</i>
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
echo " Vmess Account Unlock Successfully"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo " Client Name : $user"
echo " Status  : Unlocked"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vmess
}
function res-user(){
clear
cd
if [ ! -e /etc/vmess/akundelete ]; then
echo "" > /etc/vmess/akundelete
fi
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/vmess/akundelete")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Restore Vmess Account ⇲    ${NC} $COLOR1 $NC"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "You have no existing user Expired!"
echo ""
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
m-vmess
fi
clear
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Restore Vmess Account ⇲    ${NC} $COLOR1 $NC"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo " Select the existing client you want to Restore"
echo " ketik [0] kembali kemenu"
echo " ketik [999] untuk delete semua Akun"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "     No  User   Expired"
grep -E "^### " "/etc/vmess/akundelete" | cut -d ' ' -f 2-3 | nl -s ') '
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
if [[ ${CLIENT_NUMBER} == '1' ]]; then
read -rp "Select one client [1]: " CLIENT_NUMBER
else
read -rp "Select one client [1-${NUMBER_OF_CLIENTS}] to Unlock: " CLIENT_NUMBER
if [[ ${CLIENT_NUMBER} == '0' ]]; then
m-vmess
fi
if [[ ${CLIENT_NUMBER} == '999' ]]; then
rm /etc/vmess/akundelete
m-vmess
fi
fi
done
until [[ $masaaktif =~ ^[0-9]+$ ]]; do
read -p "Expired (days): " masaaktif
done
until [[ $iplim =~ ^[0-9]+$ ]]; do
read -p "Limit User (IP) or 0 Unlimited: " iplim
done
until [[ $Quota =~ ^[0-9]+$ ]]; do
read -p "Limit Quota (GB) or 0 Unlimited: " Quota
done
if [ ${iplim} = '0' ]; then
iplim="9999"
fi
if [ ${Quota} = '0' ]; then
Quota="9999"
fi
user=$(grep -E "^### " "/etc/vmess/akundelete" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
uuid=$(grep -E "^### " "/etc/vmess/akundelete" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
sed -i '/#vmess$/a\#vm '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\#vmg '"$user $exp $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
echo "${iplim}" >/etc/vmess/${user}IP
c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))
if [[ ${c} != "0" ]]; then
echo "${d}" >/etc/vmess/${user}
fi
sed -i "/### ${user} ${exp} ${uuid}/d" /etc/vmess/akundelete
systemctl restart xray
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>  XRAY VMESS RESTORE</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domain} </code>
<b>ISP      :</b> <code>$ISP $CITY </code>
<b>USERNAME :</b> <code>$user </code>
<b>IP LIMIT  :</b> <code>$iplim IP </code>
<b>Quota LIMIT  :</b> <code>$Quota GB </code>
<b>EXPIRED  :</b> <code>$exp </code>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Succes Restore This Akun...</i>
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
echo " Vmess Account Restore Successfully"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo " DOMAIN : $domain"
echo " ISP  : $ISP $CITY"
echo " USERNAME : $user"
echo " IP LIMIT : $iplim IP"
echo " EXPIRED  : $exp"
echo " Succes to Restore"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vmess
}
function quota-user(){
clear
cd
if [ ! -e /etc/vmess/userQuota ]; then
echo "" > /etc/vmess/userQuota
fi
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/vmess/userQuota")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Unlock Vmess Account ⇲     ${NC} $COLOR1 $NC"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "You have no existing user Lock!"
echo ""
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
m-vmess
fi
clear
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "$COLOR1 ${NC}${COLBG1}    ${WH}⇱ Unlock Vmess Account ⇲     ${NC} $COLOR1 $NC"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo " Select the existing client you want to Unlock"
echo " ketik [0] kembali kemenu"
echo " ketik [999] untuk delete semua Akun"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "     No  User   Expired"
grep -E "^### " "/etc/vmess/userQuota" | cut -d ' ' -f 2-3 | nl -s ') '
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
if [[ ${CLIENT_NUMBER} == '1' ]]; then
read -rp "Select one client [1]: " CLIENT_NUMBER
else
read -rp "Select one client [1-${NUMBER_OF_CLIENTS}] to Unlock: " CLIENT_NUMBER
if [[ ${CLIENT_NUMBER} == '0' ]]; then
m-vmess
fi
if [[ ${CLIENT_NUMBER} == '999' ]]; then
rm /etc/vmess/userQuota
m-vmess
fi
fi
done
user=$(grep -E "^### " "/etc/vmess/userQuota" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/vmess/userQuota" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^### " "/etc/vmess/userQuota" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
sed -i '/#vmess$/a\#vm '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\#vmg '"$user $exp $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
sed -i "/^### $user $exp $uuid/d" /etc/vmess/userQuota
systemctl restart xray
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>  XRAY VMESS UNLOCKED</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<b>DOMAIN   :</b> <code>${domain} </code>
<b>ISP      :</b> <code>$ISP $CITY </code>
<b>USERNAME :</b> <code>$user </code>
<b>EXPIRED  :</b> <code>$exp </code>
<code>◇━━━━━━━━━━━━━━◇</code>
<i>Succes Unlocked This Akun...</i>
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
echo " Vmess Account Unlock Successfully"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo " Client Name : $user"
echo " Status  : Unlocked"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vmess
}
clear
author=$(cat /etc/profil)
echo -e "$COLOR1╭───────────────────────────────────────────╮${NC}"
echo -e "$COLOR1│${NC}             ${WH}• VMESS PANEL MENU •${NC}          $COLOR1│${NC}"
echo -e "$COLOR1├─────────────────────┬─────────────────────┤${NC}"
echo -e "$COLOR1│${NC} ${WH}[01] ADD AKUN${NC}       $COLOR1│${NC} ${WH}[07] CHANGE LIMIT${NC}   $COLOR1│${NC}"
echo -e "$COLOR1│${NC} ${WH}[02] TRIAL AKUN${NC}     $COLOR1│${NC} ${WH}[08] SETUP LOCK${NC}     $COLOR1│${NC}"
echo -e "$COLOR1│${NC} ${WH}[03] RENEW AKUN${NC}     $COLOR1│${NC} ${WH}[09] UNLOCK IP${NC}      $COLOR1│${NC}"
echo -e "$COLOR1│${NC} ${WH}[04] DELETE AKUN${NC}    $COLOR1│${NC} ${WH}[10] UNLOCK QUOTA${NC}   $COLOR1│${NC}"
echo -e "$COLOR1│${NC} ${WH}[05] CEK ONLINE${NC}     $COLOR1│${NC} ${WH}[11] RESTORE AKUN${NC}   $COLOR1│${NC}"
echo -e "$COLOR1│${NC} ${WH}[06] CEK CONFIG${NC}     $COLOR1│${NC} ${WH}[12] AUTO LIMIT${NC}     $COLOR1│${NC}"
echo -e "$COLOR1├─────────────────────┴─────────────────────┤${NC}"
echo -e "$COLOR1│${NC} ${WH}[00] GO BACK / EXIT MENU${NC}                  $COLOR1│${NC}"
echo -e "$COLOR1╰───────────────────────────────────────────╯${NC}"
echo -e "              ${WH}• $author •${NC}              "
echo -e ""
echo -ne " ${WH}Select menu ${COLOR1}: ${WH}"; read opt

case $opt in
    01 | 1) clear ; add-vmess ;;
    02 | 2) clear ; trial-vmess ;;
    03 | 3) clear ; renew-vmess ;;
    04 | 4) clear ; del-vmess ;;
    05 | 5) clear ; cek-vmess ;;
    06 | 6) clear ; list-vmess ;;
    07 | 7) clear ; limit-vmess ;;
    08 | 8) clear ; login-vmess ;;
    09 | 9) clear ; lock-vmess ;;
    10 | 10) clear ; quota-user ;;
    11 | 11) clear ; res-user ;;
    12 | 12) clear ; toggle_autokick_xray ;;
    00 | 0) clear ; menu ;;
    *) clear ; m-vmess ;;
esac
