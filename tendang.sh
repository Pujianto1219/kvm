#!/bin/bash
# ==========================================
# AutoKill & Strike System (Multi-Login & Quota)
# ==========================================

# Pastikan layanan 'at' berjalan untuk fitur Auto-Unlock
if ! command -v at &> /dev/null; then
    apt-get install at -y >/dev/null 2>&1
    systemctl enable --now atd >/dev/null 2>&1
fi

if [ -e "/var/log/auth.log" ]; then
    OS=1;
    LOG="/var/log/auth.log";
elif [ -e "/var/log/secure" ]; then
    OS=2;
    LOG="/var/log/secure";
else
    exit 0;
fi

cat /etc/passwd | grep "/home/" | cut -d":" -f1 > /tmp/user.txt
username1=( `cat "/tmp/user.txt" `);
i="0";
for user in "${username1[@]}"
do
    username[$i]=`echo $user | sed 's/'\''//g'`;
    jumlah[$i]=0;
    i=$i+1;
done

# ==========================================
# MENGHITUNG KONEKSI DROPBEAR
# ==========================================
cat $LOG | grep -i dropbear | grep -i "Password auth succeeded" > /tmp/log-db.txt
proc=( `ps aux | grep -i dropbear | awk '{print $2}'`);
for PID in "${proc[@]}"
do
    cat /tmp/log-db.txt | grep "dropbear\[$PID\]" > /tmp/log-db-pid.txt
    NUM=`cat /tmp/log-db-pid.txt | wc -l`;
    USER=`cat /tmp/log-db-pid.txt | awk '{print $10}' | sed 's/'\''//g'`;
    if [ $NUM -eq 1 ]; then
        i=0;
        for user1 in "${username[@]}"
        do
            if [ "$USER" == "$user1" ]; then
                jumlah[$i]=`expr ${jumlah[$i]} + 1`;
            fi
            i=$i+1;
        done
    fi
done

# ==========================================
# MENGHITUNG KONEKSI OPENSSH
# ==========================================
cat $LOG | grep -i sshd | grep -i "Accepted password for" > /tmp/log-db.txt
data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);
for PID in "${data[@]}"
do
    cat /tmp/log-db.txt | grep "sshd\[$PID\]" > /tmp/log-db-pid.txt;
    NUM=`cat /tmp/log-db-pid.txt | wc -l`;
    USER=`cat /tmp/log-db-pid.txt | awk '{print $9}'`;
    if [ $NUM -eq 1 ]; then
        i=0;
        for user1 in "${username[@]}"
        do
            if [ "$USER" == "$user1" ]; then
                jumlah[$i]=`expr ${jumlah[$i]} + 1`;
            fi
            i=$i+1;
        done
    fi
done

# ==========================================
# EKSEKUSI TENDANG & STRIKE SYSTEM
# ==========================================
ACTION_TAKEN=0

for i in ${!username[*]}
do
    USER_LOCKED=0
    USER_ACC="${username[$i]}"

    # CEK STATUS AKUN (Apakah sedang digembok?)
    # Jika sudah digembok, lewati! Agar tidak terkena strike berkali-kali saat sedang dihukum.
    STATUS_AKUN=$(passwd -S $USER_ACC 2>/dev/null | awk '{print $2}')
    if [ "$STATUS_AKUN" == "L" ]; then
        continue
    fi

    # ------------------------------------------
    # 1. CEK LIMIT KUOTA (Hukuman: LOCK PERMANENT)
    # ------------------------------------------
    if [ -f "/etc/xray/sshx/${USER_ACC}Quota" ] && [ -f "/etc/xray/sshx/${USER_ACC}Usage" ]; then
        limitquota=$(cat /etc/xray/sshx/${USER_ACC}Quota)
        usagequota=$(cat /etc/xray/sshx/${USER_ACC}Usage)
        
        if [[ "$limitquota" =~ ^[0-9]+$ ]] && [[ "$usagequota" =~ ^[0-9]+$ ]]; then
            if [ "$limitquota" -ne "0" ] && [ "$limitquota" -ne "9999" ]; then
                if [ "$usagequota" -ge "$limitquota" ]; then
                    passwd -l $USER_ACC > /dev/null 2>&1
                    pkill -u $USER_ACC
                    USER_LOCKED=1
                    ACTION_TAKEN=1
                fi
            fi
        fi
    fi

    # ------------------------------------------
    # 2. CEK LIMIT IP (Hukuman: STRIKE 1, 2, dan 3)
    # ------------------------------------------
    if [ $USER_LOCKED -eq 0 ]; then
        if [ -f "/etc/xray/sshx/${USER_ACC}IP" ]; then
            limitip=$(cat /etc/xray/sshx/${USER_ACC}IP)
            
            if [ "$limitip" -ne "0" ] && [ "$limitip" -ne "9999" ]; then
                if [ "${jumlah[$i]}" -gt "$limitip" ]; then
                    
                    # File pencatat dosa (Strike)
                    STRIKE_FILE="/etc/xray/sshx/${USER_ACC}Strike"
                    if [ ! -f "$STRIKE_FILE" ]; then
                        echo "0" > "$STRIKE_FILE"
                    fi
                    
                    # Tambah dosa 1
                    STRIKE=$(cat "$STRIKE_FILE")
                    STRIKE=$((STRIKE + 1))
                    echo "$STRIKE" > "$STRIKE_FILE"

                    if [ "$STRIKE" -eq 1 ]; then
                        # PELANGGARAN PERTAMA (Lock 5 Menit)
                        passwd -l $USER_ACC > /dev/null 2>&1
                        pkill -u $USER_ACC
                        echo "passwd -u $USER_ACC" | at now + 5 minutes &> /dev/null
                        ACTION_TAKEN=1
                        
                    elif [ "$STRIKE" -eq 2 ]; then
                        # PELANGGARAN KEDUA (Lock 10 Menit)
                        passwd -l $USER_ACC > /dev/null 2>&1
                        pkill -u $USER_ACC
                        echo "passwd -u $USER_ACC" | at now + 10 minutes &> /dev/null
                        ACTION_TAKEN=1
                        
                    elif [ "$STRIKE" -ge 3 ]; then
                        # PELANGGARAN KETIGA (Hapus Permanen)
                        pkill -u $USER_ACC
                        userdel -f $USER_ACC > /dev/null 2>&1
                        
                        # Bersihkan semua sampah dan UI HTML miliknya
                        rm -f /etc/xray/sshx/${USER_ACC}* > /dev/null 2>&1
                        rm -f /home/vps/public_html/ssh-${USER_ACC}.html > /dev/null 2>&1
                        sed -i "/^### $USER_ACC/d" /etc/xray/ssh
                        ACTION_TAKEN=1
                    fi
                    
                fi
            fi
        fi
    fi
done

# ==========================================
# RESTART SERVICE JIKA ADA YANG DITENDANG
# ==========================================
if [ $ACTION_TAKEN -eq 1 ]; then
    if [ $OS -eq 1 ]; then
        systemctl restart ssh
        systemctl restart sshd
    fi
    systemctl restart dropbear
fi