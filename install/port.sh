#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
IZIN=$( curl https://raw.githubusercontent.com/yasrilpujianto-ship-it/ip/main/ip | grep $MYIP )
if [ $MYIP = $MYIP ]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Please Contact Admin!!"
echo -e "${NC}${LIGHT}Telegram : https://t.me/ whatsapp : wa.me/+"
exit 0
fi
clear
echo -e "${tyblue}|━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━|${NC}"
echo -e "${tyblue}|           ♡ PORT SERVER VPS AKTIF                |${NC}"
echo -e "${tyblue}|━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━|${NC}"
echo -e "${tyblue}|●⏩ Open VPN                : 2086 ⏪             |${NC}"
echo -e "${tyblue}|●⏩ SSH SSL Websocket       : 443 ⏪              |${NC}"
echo -e "${tyblue}|●⏩ SSH Websocket           : [ all port ] ⏪     |${NC}"
echo -e "${tyblue}|●⏩ Stunnel                 : 8443,8880 ⏪        |${NC}"
echo -e "${tyblue}|●⏩ Vmess WS TLS            : 443 ⏪              |${NC}"
echo -e "${tyblue}|●⏩ Vless WS TLS            : 443 ⏪              |${NC}"
echo -e "${tyblue}|●⏩ Trojan WS TLS           : 443 ⏪              |${NC}"
echo -e "${tyblue}|●⏩ Shadowsocks WS TLS      : 443 ⏪              |${NC}"
echo -e "${tyblue}|●⏩ Vmess gRPC              : 443 ⏪              |${NC}"
echo -e "${tyblue}|●⏩ Vless gRPC              : 443 ⏪              |${NC}"
echo -e "${tyblue}|●⏩ Trojan gRPC             : 443 ⏪              |${NC}"
echo -e "${tyblue}|●⏩ Shadowsocks gRPC        : 443 ⏪              |${NC}"
echo -e "${tyblue}|●⏩ Vmess WS none TLS       : 80 ⏪               |${NC}"
echo -e "${tyblue}|●⏩ Vless WS none TLS       : 80 ⏪               |${NC}"
echo -e "${tyblue}|●⏩ Trojan WS none TLS      : 80 ⏪               |${NC}"
echo -e "${tyblue}|●⏩ Shadowsocks WS none TLS : 80 ⏪               |${NC}"
echo -e "${tyblue}|━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━|${NC}"
echo -e "${tyblue}|            ♡ SCRIPT BY VPN               |${NC}"
echo -e "${tyblue}|━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━|${NC}"
echo -e ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; menu ;;
2) exit ;;
*) echo "SALAH TEKAN" ; sleep 1 ; m-port ;;
esac
