#!/bin/bash
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
colornow=$(cat /etc/rmbl/theme/color.conf 2>/dev/null || echo "cyan")
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/rmbl/theme/$colornow 2>/dev/null | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/rmbl/theme/$colornow 2>/dev/null | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
ipsaya=$(wget -qO- ifconfig.me)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/Pujianto1219/ip/main/ip"

checking_sc() {
    useexp=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
    if [[ "$date_list" < "$useexp" ]]; then
        echo -ne
    else
        echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
        echo -e "$COLOR1 ${NC} ${COLBG1}          ${WH}• AUTOSCRIPT PREMIUM •               ${NC} $COLOR1 $NC"
        echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
        echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
        echo -e "            ${RED}PERMISSION DENIED !${NC}"
        echo -e "   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}"
        echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
        echo -e "             \033[0;33mContact Admin :${NC}"
        echo -e "     \033[0;36mTelegram${NC}: t.me/AimanVpnExpress"
        echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
        exit
    fi
}
checking_sc

rm -rf /tmp/ssh
clear
bash2=$( pgrep bash | wc -l )
if [[ $bash2 -gt "20" ]]; then
    killall bash
fi

TIMES="10"
CHATID=$(cat /etc/perlogin/id 2>/dev/null)
KEY=$(cat /etc/perlogin/token 2>/dev/null)
URL="https://api.telegram.org/bot$KEY/sendMessage"
domen=$(cat /etc/xray/domain 2>/dev/null)
DATE=$(date +'%Y-%m-%d')
TIME=$(date +'%H:%M:%S')
ISP=$(cat /etc/xray/isp 2>/dev/null)
CITY=$(cat /etc/xray/city 2>/dev/null)

# ---------------------------------------------------------
# MENGAMBIL KONFIGURASI SISTEM
# ---------------------------------------------------------
type=$(cat /etc/typessh 2>/dev/null || echo "delete")
waktulock=$(cat /etc/waktulockssh 2>/dev/null || echo "15")
notif_limit=$(cat /etc/xray/sshx/notif 2>/dev/null || echo "3")
sp1_dur=$(cat /etc/xray/sshx/sp1 2>/dev/null || echo "15")
sp2_dur=$(cat /etc/xray/sshx/sp2 2>/dev/null || echo "30")

if [ -e "/var/log/auth.log" ]; then
    OS=1; LOG="/var/log/auth.log";
elif [ -e "/var/log/secure" ]; then
    OS=2; LOG="/var/log/secure";
fi

# ---------------------------------------------------------
# MEMBACA LOG SSH & DROPBEAR
# ---------------------------------------------------------
cat /etc/passwd | grep "/home/" | cut -d":" -f1 > /etc/user.txt
username1=( `cat "/etc/user.txt" `)
i="0"
for user in "${username1[@]}"; do
    username[$i]=$(echo $user | sed "s/'//g")
    jumlah[$i]=0
    i=$((i+1))
done

# Parsing Dropbear
cat $LOG | grep -i dropbear | grep -i "Password auth succeeded" > /tmp/log-db.txt
proc=( $(ps aux | grep -i dropbear | awk '{print $2}') )
for PID in "${proc[@]}"; do
    cat /tmp/log-db.txt | grep "dropbear\[$PID\]" > /tmp/log-db-pid.txt
    NUM=$(wc -l < /tmp/log-db-pid.txt)
    USER=$(awk '{print $10}' /tmp/log-db-pid.txt | sed "s/'//g")
    IP=$(awk '{print $12}' /tmp/log-db-pid.txt)
    if [ $NUM -eq 1 ]; then
        TIME_LOG=$(date +'%H:%M:%S')
        echo "$USER $TIME_LOG : $IP" >> /tmp/ssh
        i=0
        for user1 in "${username[@]}"; do
            if [ "$USER" == "$user1" ]; then
                jumlah[$i]=$((jumlah[$i] + 1))
            fi
            i=$((i+1))
        done
    fi
done

# Parsing OpenSSH
cat $LOG | grep -i sshd | grep -i "Accepted password for" > /tmp/log-db.txt
data=( $(ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}') )
for PID in "${data[@]}"; do
    cat /tmp/log-db.txt | grep "sshd\[$PID\]" > /tmp/log-db-pid.txt
    NUM=$(wc -l < /tmp/log-db-pid.txt)
    USER=$(awk '{print $9}' /tmp/log-db-pid.txt)
    IP=$(awk '{print $11}' /tmp/log-db-pid.txt)
    if [ $NUM -eq 1 ]; then
        TIME_LOG=$(date +'%H:%M:%S')
        echo "$USER $TIME_LOG : $IP" >> /tmp/ssh
        i=0
        for user1 in "${username[@]}"; do
            if [ "$USER" == "$user1" ]; then
                jumlah[$i]=$((jumlah[$i] + 1))
            fi
            i=$((i+1))
        done
    fi
done

# ---------------------------------------------------------
# PROSES TINDAKAN MULTI LOGIN
# ---------------------------------------------------------
j="0"
for i in ${!username[*]}; do
    limitip=$(cat /etc/xray/sshx/${username[$i]}IP 2>/dev/null)
    if [[ -z "$limitip" ]]; then limitip="0"; fi

    # JIKA MELEBIHI LIMIT IP
    if [[ ${jumlah[$i]} -gt $limitip && $limitip -ne 0 ]]; then
        date_now=$(date +"%Y-%m-%d %X")
        echo "$date_now - ${username[$i]} - ${jumlah[$i]}" >> /etc/xray/sshx/${username[$i]}login
        
        sship=$(wc -l < /etc/xray/sshx/${username[$i]}login)
        sship2=$(grep -w "${username[$i]}" /tmp/ssh | cut -d ' ' -f 2-8 | nl -s '. ' 2>/dev/null)

        # Hapus log agar tidak dideteksi terus jika di-lock
        sed -i "/${username[$i]}/d" /var/log/auth.log 2>/dev/null

        # -------------------------------------------------
        # KONDISI 1: KIRIM PERINGATAN (BELUM MENCAPAI BATAS)
        # -------------------------------------------------
        if [ "$sship" -lt "$notif_limit" ]; then
            TEXT="
🧿───────────────────🧿            
           ⚠️ PERINGATAN MULTI LOGIN ⚠️
🔹 Informasi Pelanggaran
┌─────────────────────
│Username   : <code>${username[$i]}</code>
│Provider   : $ISP
│Limit IP   : $limitip IP
│Login IP   : ${jumlah[$i]} IP
│Peringatan : ke-$sship dari $notif_limit Limit Peringatan
└─────────────────────
🫧IP yang terpantau Login:
<code>$sship2</code>
🧿───────────────────🧿
♨ Harap patuhi aturan atau akun akan disanksi ♨
"
            curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
        
        # -------------------------------------------------
        # KONDISI 2: EKSEKUSI SANKSI (MENCAPAI BATAS NOTIF)
        # -------------------------------------------------
        elif [ "$sship" -ge "$notif_limit" ]; then
            
            # --- JIKA MODE AUTO LOCK ---
            if [ "$type" == "lock" ]; then
                passwd -l ${username[$i]} >/dev/null 2>&1
                
                # Buat Cronjob untuk auto-unlock dan self-delete
                M=$(date -d "$waktulock minutes" +%M)
                H=$(date -d "$waktulock minutes" +%H)
                echo "$M $H * * * root passwd -u ${username[$i]} && rm -f /etc/cron.d/ssh_${username[$i]}" > /etc/cron.d/ssh_${username[$i]}
                
                TINDAKAN="DIKUNCI SEMENTARA ($waktulock Menit)"

            # --- JIKA MODE AUTO DELETE ---
            elif [ "$type" == "delete" ]; then
                passwd -l ${username[$i]} >/dev/null 2>&1
                userdel -f ${username[$i]} >/dev/null 2>&1
                sed -i "/^### ${username[$i]} /d" /etc/xray/ssh
                
                TINDAKAN="DIHAPUS PERMANEN"

            # --- JIKA MODE SANKSI BERTINGKAT ---
            elif [ "$type" == "bertingkat" ]; then
                sp_file="/etc/xray/sshx/${username[$i]}_sp"
                current_sp=$(cat "$sp_file" 2>/dev/null || echo "0")
                new_sp=$((current_sp + 1))
                echo "$new_sp" > "$sp_file"

                if [ "$new_sp" -eq 1 ]; then
                    passwd -l ${username[$i]} >/dev/null 2>&1
                    M=$(date -d "$sp1_dur minutes" +%M)
                    H=$(date -d "$sp1_dur minutes" +%H)
                    echo "$M $H * * * root passwd -u ${username[$i]} && rm -f /etc/cron.d/ssh_${username[$i]}" > /etc/cron.d/ssh_${username[$i]}
                    TINDAKAN="SP-1: KUNCI SEMENTARA ($sp1_dur Menit)"
                
                elif [ "$new_sp" -eq 2 ]; then
                    passwd -l ${username[$i]} >/dev/null 2>&1
                    M=$(date -d "$sp2_dur minutes" +%M)
                    H=$(date -d "$sp2_dur minutes" +%H)
                    echo "$M $H * * * root passwd -u ${username[$i]} && rm -f /etc/cron.d/ssh_${username[$i]}" > /etc/cron.d/ssh_${username[$i]}
                    TINDAKAN="SP-2: KUNCI SEMENTARA ($sp2_dur Menit)"
                
                elif [ "$new_sp" -ge 3 ]; then
                    userdel -f ${username[$i]} >/dev/null 2>&1
                    sed -i "/^### ${username[$i]} /d" /etc/xray/ssh
                    rm -f "$sp_file"
                    TINDAKAN="SP-3: AKUN DIHAPUS PERMANEN"
                fi
            fi

            # NOTIFIKASI SANKSI DITERAPKAN KE TELEGRAM
            TEXT_SANKSI="
🧿───────────────────🧿            
            🚨 PELANGGARAN FATAL 🚨
🔹 Tindakan Otomatis Diterapkan
┌─────────────────────
│Username   : <code>${username[$i]}</code>
│Provider   : $ISP
│Limit IP   : $limitip IP
│Login IP   : ${jumlah[$i]} IP
│Sanksi     : <b>$TINDAKAN</b>
└─────────────────────
🫧IP Terakhir yang terpantau:
<code>$sship2</code>
🧿───────────────────🧿
♨ Sistem otomatis memutus akses akun tersebut ♨
"
            curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT_SANKSI&parse_mode=html" $URL >/dev/null
            
            # Reset Log Peringatan agar hitungan kembali dari nol (Untuk Bertingkat)
            rm -rf /etc/xray/sshx/${username[$i]}login

            # Force Restart Dropbear & Tunnel untuk menendang koneksi
            systemctl restart ws-stunnel > /dev/null 2>&1
            systemctl restart dropbear > /dev/null 2>&1
        fi
        j=$((j+1))
    fi
done

# Restart SSHD Service Jika ada yang ditendang
if [ $j -gt 0 ]; then
    if [ $OS -eq 1 ]; then
        service ssh restart > /dev/null 2>&1;
    fi
    if [ $OS -eq 2 ]; then
        service sshd restart > /dev/null 2>&1;
    fi
fi
