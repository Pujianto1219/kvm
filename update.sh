#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/rmbl/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/rmbl/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/rmbl/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
###########- END COLOR CODE -##########
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}                 ⇱ UPDATE ⇲                     ${NC} $COLOR1 $NC"
echo -e "$COLOR1 ${NC} ${COLBG1}             ⇱ SCRIPT TERBARU ⇲                 ${NC} $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"

# Daftar semua file yang dikelola oleh script ini
FILES="menu m-trgo restore backup addnoobz cek-noobz m-noobz m-vmess m-vless m-trojan m-system m-sshovpn m-ssws running m-update m-backup m-theme m-ip m-bot update ws-dropbear bckpbot tendang bottelegram cleaner m-allxray xraylimit xp trialvmess trialvless trialtrojan trialssh bantwidth ws-stunnel autocpu speedtest"

# Hapus menu lama
cd /usr/bin
for file in $FILES; do
    rm -rf $file
done

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
    echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
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
        echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}

res1() {
    # Download menu
    wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/menu.sh"
    wget -q -O /usr/bin/m-trgo "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-trgo.sh"
    wget -q -O /usr/bin/restore "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/restore.sh"
    wget -q -O /usr/bin/backup "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/backup.sh"
    wget -q -O /usr/bin/addnoobz "https://raw.githubusercontent.com/Pujianto1219/kvm/main/bot/addnoobz.sh"
    wget -q -O /usr/bin/cek-noobz "https://raw.githubusercontent.com/Pujianto1219/kvm/main/bot/cek-noobz.sh"
    wget -q -O /usr/bin/m-noobz "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-noobz.sh"
    wget -q -O /usr/bin/m-ip "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-ip.sh"
    wget -q -O /usr/bin/m-bot "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-bot.sh"
    wget -q -O /usr/bin/update "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/update.sh"
    wget -q -O /usr/bin/m-theme "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-theme.sh"
    wget -q -O /usr/bin/m-vmess "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-vmess.sh"
    wget -q -O /usr/bin/m-vless "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-vless.sh"
    wget -q -O /usr/bin/m-trojan "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-trojan.sh"
    wget -q -O /usr/bin/m-system "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-system.sh"
    wget -q -O /usr/bin/m-sshovpn "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-sshovpn.sh"
    wget -q -O /usr/bin/m-ssws "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-ssws.sh"
    wget -q -O /usr/bin/running "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/running.sh"
    wget -q -O /usr/bin/m-backup "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-backup.sh"
    wget -q -O /usr/bin/m-update "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-update.sh"
    wget -q -O /usr/bin/speedtest "https://raw.githubusercontent.com/Pujianto1219/kvm/main/speedtest_cli.py"
    wget -q -O /usr/bin/bckpbot "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/bckpbot.sh"
    wget -q -O /usr/bin/tendang "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/tendang.sh"
    wget -q -O /usr/bin/bottelegram "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/bottelegram.sh"
    wget -q -O /usr/bin/m-allxray "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/m-allxray.sh"
    wget -q -O /usr/bin/xraylimit "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/xraylimit.sh"
    wget -q -O /usr/bin/trialvmess "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/trialvmess.sh"
    wget -q -O /usr/bin/trialvless "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/trialvless.sh"
    wget -q -O /usr/bin/trialtrojan "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/trialtrojan.sh"
    wget -q -O /usr/bin/trialssh "https://raw.githubusercontent.com/Pujianto1219/kvm/main/menu/trialssh.sh"
    wget -q -O /usr/bin/autocpu "https://raw.githubusercontent.com/Pujianto1219/kvm/main/install/autocpu.sh"
    wget -q -O /usr/bin/bantwidth "https://raw.githubusercontent.com/Pujianto1219/kvm/main/install/bantwidth"
    wget -q -O /usr/bin/ws-stunnel "https://raw.githubusercontent.com/Pujianto1219/kvm/main/sshws/ws-stunnel"

    # Proses otomatis FIX ^M (CRLF to LF) dan memberikan izin eksekusi (chmod)
    for file in $FILES; do
        if [ -f "/usr/bin/$file" ]; then
            sed -i 's/\r$//' "/usr/bin/$file"
            chmod +x "/usr/bin/$file"
        fi
    done
    clear
}

echo -e ""
echo -e "  \033[1;91m Update Script...\033[1;37m"
fun_bar 'res1'

echo -e ""
cd
menu
