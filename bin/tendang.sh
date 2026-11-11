#!/bin/bash
# ==========================================
# AutoKill SSH / Dropbear Multi-Login
# ==========================================
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

# Cek Dropbear
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

# Cek OpenSSH
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

# Eksekusi Tendang
j="0";
for i in ${!username[*]}
do
    if [ -f "/etc/xray/sshx/${username[$i]}IP" ]; then
        limitip=$(cat /etc/xray/sshx/${username[$i]}IP)
        if [ "$limitip" -eq "0" ] || [ "$limitip" -eq "9999" ]; then
            continue
        fi
        if [ "${jumlah[$i]}" -gt "$limitip" ]; then
            passwd -l ${username[$i]} > /dev/null 2>&1
            pkill -u ${username[$i]}
            if [ $OS -eq 1 ]; then
                systemctl restart ssh
                systemctl restart sshd
            fi
            systemctl restart dropbear
            j=`expr $j + 1`;
        fi
    fi
done