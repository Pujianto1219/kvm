#!/bin/bash
clear
# // color format 38
CC='\e[38;5;14m'  # 
LO='\e[38;5;162m' # PURPLE HACKER
UK='\e[38;5;99m'  # UNGU KOLOT
BK='\e[38;5;196m' # BEREM KOLOT 
R1='\e[38;5;155m' # HEJO SEMU BODAS
R2='\e[38;5;49m'  # HEJO LIME / APEL
BC='\e[38;5;195m' # BODAS CERAH PISAN
HU='\e[38;5;115m' # HEJO SEMU ABU
UB='\e[38;5;147m' # UNGU KABODASAN
KT='\e[38;5;187m' # KONENG TARIGU
# // color fromat 5 
BlueCyan='\e[5;36m'
WhiteBe='\e[5;37m'
GreenBe='\e[5;32m'
Xark='\e[0m'

systemctl daemon-reload
systemctl start xbot
systemctl enable xbot
systemctl restart xbot

# // STATUS SERVICE BOT
bot_service=$(systemctl status cybervpn | grep active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $bot_service == "running" ]]; then 
   sts_bot="\e[92;1m[ON]\e[0m"
else
   sts_bot="\e[91;1m[OF]\e[0m"
fi


function Banner_Libev() {
clear
  echo -e "${R2} ┌━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┐${Xark} "
  echo -e "${LO}              BOT LIBEV              ${Xark} "
  echo -e "${R2} └━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┘${Xark} "
}



function BR1() {
  echo -e "${R2} ┌━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┐${Xark} "
}

function BR2() {
  echo -e "${R2} └━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┘${Xark} "
}


function Menu_Features() {
  BR1
  echo -e "\e[95;1m  STATUS BOT : $sts_bot"
  echo -e "\e[38;5;49m "
  echo -e "\e[38;5;49m │\e[92;1m[01]•\e[0;36m CREATE BOT TELEGRAM  "
  echo -e "\e[38;5;49m │\e[92;1m[02]•\e[0;36m DELETE BOT TELEGRAM  "
  echo -e "\e[38;5;49m │\e[92;1m[03]•\e[0;36m RESTAR BOT TELEGRAM  "
  echo -e "\e[38;5;49m │\e[92;1m[xx]•\e[0;31m EXIT ${Xark}    "
  BR2
  echo -e ""
}



Banner_Libev
Menu_Features
read -p "  just Input 1-3 or xx :  "  opt
echo -e   ""
case $opt in
01 | 1) clear ; wget https://raw.githubusercontent.com/gazzent/kvm/main/bot/bot3.sh && chmod +x bot3.sh && ./bot3.sh ;;
02 | 2) clear ; del-bot ;;
03 | 3) clear ; restart-bot ;;
*) clear ; menu ;;
esac
