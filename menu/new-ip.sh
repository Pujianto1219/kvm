# Decrypted by LT | FUSCATOR
# Github- https://github.com/LunaticTunnel/Absurd

clear
NC='\e[0m'
ipsaya=$(wget -qO- ipinfo.io/ip)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/Pujianto1219/ip/main/ip"
checking_sc() {
useexp=$(wget -qO- $data_ip | grep $ipsaya | awk '{print $3}')
if [[ $date_list < $useexp ]]; then
echo -ne
else
echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
echo -e "\033[42m          DAFTAR KE OWNER DULU SU !!       \033[0m"
echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
echo -e ""
echo -e "            ${RED}PERMISSION DENIED !${NC}"
echo -e "        \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}"
echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
echo -e "              \033[0;33mContact Admin :${NC}"
echo -e "         \033[0;36mTelegram${NC} t.me/"
echo -e "       ${GREEN}WhatsApp${NC} wa.me/+628981874211"
echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
exit
fi
}
checking_sc
clear
Repo1="https://raw.githubusercontent.com/Pujianto1219/ip/main/"
export MYIP=$( curl -s https://ipinfo.io/ip/ )
SELLER=$(curl -sS ${Repo1}ip | grep $MYIP | awk '{print $2}')
Exp100=$(curl -sS ${Repo1}ip | grep $MYIP | awk '{print $3}')
data_ip="https://raw.githubusercontent.com/Pujianto1219/ip/main/ip"
d2=$(date -d "$date_list" +"+%s")
d1=$(date -d "$Exp" +"+%s")
dayleft=$(( ($d1 - $d2) / 86400 ))
[[ ! -f /usr/bin/git ]] && apt install git -y &> /dev/null
clear
OR='\033[1;93m'
c="\033[0;36m" #biruterang
g="\e[92;1m"
p="\033[95;1m"
r="\033[1;31m"  #REDTERANG
NC='\e[0m'
gray="\e[1;30m"
Blue="\033[1;36m"
GREEN='\033[0;32m'
grenbo="\033[1;95m"
CYAN="\033[96;1m"
yell='\e[33m'
BGX="\033[42m"
END='\e[0m'
AKTIF="VERIFIED"
TOKEN="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"
REPO="https://github.com/Pujianto1219/ip.git"
EMAIL="imanfals51@gmail.com"
USER="Pujianto1219"
add-ip() {
TIMES="10"
CHATID="6198984094"
KEY="7339386828:AAGVP8M2ig8jmTw-vTh8ytKDmj4N8Aqtud4"
URL="https://api.telegram.org/bot$KEY/sendMessage"
today=`date -d "0 days" +"%Y-%m-%d"`
git clone ${REPO} /root/permission/ &> /dev/null
clear
echo -e "MASUKAN IP VPS YANG BELUM DI DAFTAR !"
echo -e ""
read -p "Input IP Address : " ip
CLIENT_EXISTS=$(grep -w $ip /root/ip/ip | wc -l)
if [[ ${CLIENT_EXISTS} == '1' ]]; then
echo "IP Already Exist !"
exit 0
fi
echo -e ""
name=GQ6EFctYeZ3D0XB`</dev/urandom tr -dc A-Z0-9 | head -c4`
echo -e ""
clear
echo -e " ${p} How Much Days Do You Want ?${NC}"
echo -e "  ${GREEN} 1.${NC}${CYAN}10K  = 30 Days${NC}"
echo -e "  ${GREEN} 2.${NC}${CYAN}20K  = 60 Days${NC}"
echo -e "  ${GREEN} 3.${NC}${CYAN}30K  = 90 Days${NC}"
echo -e "  ${GREEN} 4.${NC}${CYAN}100K = Lifetime${NC}"
echo -e "  ${GREEN} 5.${NC}${CYAN}Custom Expiration Date${NC}"
echo -e ""
read -p "Select Number 1 - 5 : " exp
if [[ ${exp} == '1' ]]; then
exp2=`date -d "30 days" +"%Y-%m-%d"`
echo "### ${name} ${exp2} ${ip}" >> /root/ip/ip
elif [[ ${exp} == '2' ]]; then
exp2=`date -d "60 days" +"%Y-%m-%d"`
echo "### ${name} ${exp2} ${ip}" >> /root/ip/ip
elif [[ ${exp} == '3' ]]; then
exp2=`date -d "90 days" +"%Y-%m-%d"`
echo "### ${name} ${exp2} ${ip}" >> /root/ip/ip
elif [[ ${exp} == '4' ]]; then
exp2=`date -d "12000 days" +"%Y-%m-%d"`
echo "### ${name} ${exp2} ${ip}" >> /root/ip/ip
elif [[ ${exp} == '5' ]]; then
read -p "Input Expired Days : " exp11
exp2=`date -d "$exp11 days" +"%Y-%m-%d"`
echo "### ${name} ${exp2} ${ip}" >> /root/ip/ip
fi
cd /root/permission
git config --global user.email "${EMAIL}" &> /dev/null
git config --global user.name "${USER}" &> /dev/null
rm -rf .git &> /dev/null
git init &> /dev/null
git add . &> /dev/null
git commit -m m &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://raw.githubusercontent.com/Pujianto1219/ip
git push -f https://${TOKEN}@github.com/Pujianto1219/ip.git &> /dev/null
rm -rf /root/permission
clear
sleep 1
echo "  Registering IP Address..."
sleep 1
echo "  Processing..."
sleep 1
echo "  Done!"
sleep 1
clear
TEXT="
<code>───────────────────────────</code>
<code>    SUCCES  REGISTERED IP VPS</code>
<code>───────────────────────────</code>
<code>USERNAME       : $name</code>
<code>IP Address     : $ip</code>
<code>Registered On  : $today</code>
<code>Expired On     : $exp2</code>
<code>───────────────────────────</code>
"
echo -e "${CYAN}┌───────────────────────────────┐$NC"
echo -e "${CYAN}│${NC}${g}  .::.${NC}${p} SUCCES ADD IP VPS ${NC}${g}.::. $NC"
echo -e "${CYAN}└───────────────────────────────┘$NC"
echo -e "${GREEN}> USERNAME   :${NC}${yell} $name"
echo -e "${GREEN}> IP ADDRESS :${NC}${yell} $ip"
echo -e "${GREEN}> REGISTERED :${NC}${yell} $today"
echo -e "${GREEN}> EXPIRED ON :${NC}${yell} $exp2"
echo -e " ${CYAN}────────────────────────────────$NC"
echo -e ""
echo -e "${GREEN} --------------$NC"
echo -e "${GREEN} OS Support$NC"
echo -e "${GREEN} ☞ Debian 10 (recommended)$NC"
echo -e "${GREEN} ☞ Ubuntu 20 $NC"
echo -e "${GREEN} --------------$NC"
echo -e ""
echo -e "${GREEN} apt install -y && apt update -y && apt upgrade -y && apt install lolcat -y && gem install lolcat && wget --no-check-certificate https://sanzpermission.serv00.net/main.sh && chmod +x main.sh && ./main.sh$NC"
echo -e ""
echo -e "${CYAN} ────────────────────────────────$NC"
echo -e "${p}  Terimakasih Telah Menggunakan$NC"
echo -e "${p}        Script Credit $NC"
echo -e "${p}       TUNNELING$NC"
echo -e "${CYAN} ────────────────────────────────$NC"
echo -e ""
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}
del-ip() {
TIMES="10"
CHATID="6198984094"
KEY="7339386828:AAGVP8M2ig8jmTw-vTh8ytKDmj4N8Aqtud4"
URL="https://api.telegram.org/bot$KEY/sendMessage"
rm -rf /root/permission
git clone ${REPO} /root/permission/ &> /dev/null
clear
echo ""
echo -e "${CYAN}┌───────────────────────────────┐$NC"
echo -e "${CYAN}│${NC}${g} .::.${NC}    LIST IP VPS     ${NC}${g}.::. $NC"
echo -e "${CYAN}└───────────────────────────────┘$NC"
grep -E "^###" "/root/ip/ip" | cut -d ' ' -f 2-6 | column -t | sort | uniq
grep -E "^#&"  "/root/ip/ip" | cut -d ' ' -f 2-6 | column -t | sort | uniq
echo -e " ${CYAN}────────────────────────────────$NC"
read -p "Input IP Address To Delete : " ipdel
name=$(cat /root/ip/ip | grep $ipdel | awk '{print $2}')
exp=$(cat /root/ip/ip | grep $ipdel | awk '{print $3}')
if [[ ${exp} == 'Lifetime' ]]; then
sed -i "/^#&   $name   $exp $ipdel/,/^},{/d" /root/ip/ip
else
sed -i "/^### $name $exp $ipdel/,/^},{/d" /root/ip/ip
fi
cd /root/permission
git config --global user.email "${EMAIL}" &> /dev/null
git config --global user.name "${USER}" &> /dev/null
rm -rf .git &> /dev/null
git init &> /dev/null
git add . &> /dev/null
git commit -m m &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://raw.githubusercontent.com/Pujianto1219/ip
git push -f https://${TOKEN}@github.com/Pujianto1219/ip.git &> /dev/null
rm -rf /root/permission
clear
sleep 1
echo "  Delete IP Address..."
sleep 1
echo "  Processing..."
sleep 1
echo "  Done!"
sleep 1
clear
TEXT1="
<code>───────────────────────────</code>
<code>    SUCCES DELETE  IP VPS</code>
<code>───────────────────────────</code>
<code>USERNAME       : $name</code>
<code>IP Address     : $ipdel</code>
<code>Expired On     : $exp</code>
<code>───────────────────────────</code>
"
echo -e "${CYAN}┌───────────────────────────────┐$NC"
echo -e "${CYAN}│${NC}${g} .::.${NC} DONE DELETE IP VPS ${NC}${g}.::. $NC"
echo -e "${CYAN}└───────────────────────────────┘$NC"
echo -e "${GREEN}> USERNAME   :${NC}${yell} $name"
echo -e "${GREEN}> IP ADDRESS :${NC}${yell} $ipdel"
echo -e "${GREEN}> EXPIRED ON :${NC}${yell} $exp"
echo -e " ${CYAN}────────────────────────────────$NC"
echo -e ""
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT1&parse_mode=html" $URL >/dev/null
}
renew-ip() {
TIMES="10"
CHATID="6198984094"
KEY="7339386828:AAGVP8M2ig8jmTw-vTh8ytKDmj4N8Aqtud4"
URL="https://api.telegram.org/bot$KEY/sendMessage"
rm -rf /root/permission
git clone ${REPO} /root/permission/ &> /dev/null
clear
echo -e "${CYAN}  ==================================$NC"
echo -e "${grenbo}            RENEW IP VPS $NC"
echo -e "${CYAN}  ==================================$NC"
grep -E "^###" "/root/ip/ip" | cut -d ' ' -f 2-6 | column -t | sort | uniq
echo -e "${CYAN}  ──────────────────────────────────$NC"
echo ""
read -p "  Input IP Address To Renew : " ipdel
read -p "  Input Days  : " days
name=$(cat /root/ip/ip | grep $ipdel | awk '{print $2}')
exp=$(cat /root/ip/ip | grep $ipdel | awk '{print $3}')
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $days))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "s/### $name $exp $ipdel/### $name $exp4 $ipdel/g" /root/ip/ip
cd /root/permission
git config --global user.email "${EMAIL}" &> /dev/null
git config --global user.name "${USER}" &> /dev/null
rm -rf .git &> /dev/null
git init &> /dev/null
git add . &> /dev/null
git commit -m m &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://raw.githubusercontent.com/Pujianto1219/ip
git push -f https://${TOKEN}@github.com/Pujianto1219/ip.git &> /dev/null
rm -rf /root/permission
clear
sleep 1
echo "  Renew IP Address..."
sleep 1
echo "  Processing..."
sleep 1
echo "  Done!"
sleep 1
clear
TEXT2="
<code>───────────────────────────</code>
<code>    SUCCES RENEW  IP VPS</code>
<code>───────────────────────────</code>
<code>USERNAME       : $name</code>
<code>IP Address     : $ipdel</code>
<code>Expired On     : $exp4</code>
<code>───────────────────────────</code>
"
echo ""
echo -e "${CYAN}  ==================================$NC"
echo -e "${grenbo}           DONE RENEW IP VPS $NC"
echo -e "${CYAN}  ==================================$NC"
echo -e "${OR}> USERNAME   :${NC}${yell} $name"
echo -e "${OR}> IP ADDRESS :${NC}${yell} $ipdel"
echo -e "${OR}> EXPIRED ON :${NC}${yell} $exp4"
echo -e " ${CYAN}───────────────────────────────────$NC"
echo -e ""
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT2&parse_mode=html" $URL >/dev/null
}
clear
echo -e " ${CYAN}  ==================================$NC"
echo -e " ${grenbo}           MENU RESSELER IP $NC"
echo -e " ${CYAN}  ==================================$NC"
echo -e " ${OR}  $NC$r NAME RESSELER   :$NC $SELLER"
echo -e " ${OR}  $NC$r STATUS RESSELER :$NC $AKTIF"
echo -e " ${CYAN}  ==================================$NC"
echo -e " ${OR}  ${NC}${g} 1.$NC ${c}ADD IP RESSELER"$NC
echo -e " ${OR}  ${NC}${g} 2.$NC ${c}DELETE IP RESSELER"$NC
echo -e " ${OR}  ${NC}${g} 3.$NC ${c}RENEW IP RESSELER"$NC
echo -e " ${OR}  ${NC}${g} 4.$NC ${c}BACK TO MENU"$NC
echo -e " ${CYAN}  ==================================$NC"
echo ""
read -p " Select From Options : " menu
case $menu in
1 | 01)
clear
add-ip
;;
2 | 02)
clear
del-ip
;;
3 | 03)
clear
renew-ip
;;
4 | 04)
menu
;;
*)
exit
;;
esac
