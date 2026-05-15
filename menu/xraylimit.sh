#!/bin/bash
biji=$(date +"%Y-%m-%d")
colornow=$(cat /etc/rmbl/theme/color.conf 2>/dev/null || echo "cyan")
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/rmbl/theme/$colornow 2>/dev/null | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/rmbl/theme/$colornow 2>/dev/null | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
ipsaya=$(wget -qO- ipinfo.io/ip)

checking_sc() {
    data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
    date_list=$(date +"%Y-%m-%d" -d "$data_server")
    data_ip="https://raw.githubusercontent.com/Pujianto1219/ip/main/ip"
    useexp=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
    if [[ $date_list < $useexp ]]; then
        echo -ne
    else
        exit 1
    fi
}
checking_sc
cd

bash2=$(pgrep bash | wc -l)
if [[ $bash2 -gt "20" ]]; then
    killall bash
fi

timenow=$(date +%T" WIB")
TIMES="10"
CHATID=$(cat /etc/perlogin/id 2>/dev/null)
KEY=$(cat /etc/perlogin/token 2>/dev/null)
URL="https://api.telegram.org/bot$KEY/sendMessage"
domen=$(cat /etc/xray/domain 2>/dev/null)
ISP=$(cat /etc/xray/isp 2>/dev/null)
CITY=$(cat /etc/xray/city 2>/dev/null)
DATE=$(date +'%Y-%m-%d')
TIME=$(date +'%H:%M:%S')

# Variabel Global Penanda Restart
RESTART_XRAY=0

# ---------------------------------------------------------
# FUNGSI BANTUAN
# ---------------------------------------------------------
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

# ---------------------------------------------------------
# CORE FUNCTION: PROSES XRAY (VMESS/VLESS/TROJAN)
# ---------------------------------------------------------
process_xray() {
    local protocol=$1
    local tag_id=$2
    local tag_grpc=$3
    local dir_limit="/etc/limit/${protocol}"
    local dir_conf="/etc/${protocol}"
    
    mkdir -p $dir_limit $dir_conf
    
    # Ambil konfigurasi saat ini dari sistem
    local type=$(cat /etc/typexray 2>/dev/null || echo "delete")
    local waktulock=$(cat /etc/waktulock 2>/dev/null || echo "15")
    local limit_notif=$(cat ${dir_conf}/notif 2>/dev/null || echo "3")
    local sp1_dur=$(cat ${dir_conf}/sp1 2>/dev/null || echo "15")
    local sp2_dur=$(cat ${dir_conf}/sp2 2>/dev/null || echo "30")

    users=($(grep "^${tag_grpc}" /etc/xray/config.json | awk '{print $2}' | sort -u))
    echo -n > /tmp/${protocol}_log

    # 1. Parsing Log Xray untuk Deteksi Multi-Login
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
            
            # CEK QUOTA
            downlink=$(xray api stats --server=127.0.0.1:10085 -name "user>>>${usr}>>>traffic>>>downlink" | grep -w "value" | awk '{print $2}' | cut -d '"' -f2)
            if [ -n "$downlink" ]; then
                current_usage=$(cat ${dir_limit}/${usr} 2>/dev/null || echo "0")
                new_usage=$((current_usage + downlink))
                echo "${new_usage}" > ${dir_limit}/${usr}
                xray api stats --server=127.0.0.1:10085 -name "user>>>${usr}>>>traffic>>>downlink" -reset > /dev/null 2>&1
            fi
            
            limit_quota=$(cat ${dir_conf}/${usr} 2>/dev/null || echo "999999999999")
            usage_quota=$(cat ${dir_limit}/${usr} 2>/dev/null || echo "0")
            
            # Jika Quota Habis, Langsung Hapus
            if [ "$usage_quota" -gt "$limit_quota" ]; then
                exp=$(grep -wE "^${tag_grpc} $usr" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
                uuid=$(grep -wE "^${tag_grpc} $usr" "/etc/xray/config.json" | cut -d ' ' -f 4 | sort | uniq)
                echo "### $usr $exp $uuid" >> ${dir_conf}/userQuota
                sed -i "/^${tag_grpc} $usr $exp/,/^},{/d" /etc/xray/config.json
                sed -i "/^${tag_id} $usr $exp/,/^},{/d" /etc/xray/config.json
                rm -f ${dir_limit}/${usr}
                
                # Tandai agar Xray direstart di akhir script
                RESTART_XRAY=1
                continue # Skip cek IP jika sudah terhapus
            fi

            # CEK MULTI LOGIN IP
            login_count=$(grep -w "${usr}" /tmp/${protocol}_log | wc -l)
            ip_limit=$(cat ${dir_conf}/${usr}IP 2>/dev/null || echo "0")
            
            if [[ ${login_count} -gt ${ip_limit} && ${ip_limit} -ne 0 ]]; then
                echo "$usr ${login_count}" >> ${dir_conf}/${usr}login
                pelanggaran_ke=$(wc -l < ${dir_conf}/${usr}login)
                ip_list=$(grep -w "${usr}" /tmp/${protocol}_log | cut -d ' ' -f 2-8 | nl -s '. ')
                usage_gb=$(convert ${usage_quota})

                # Hapus log asli agar tidak loop
                sed -i "/${usr}/d" /var/log/xray/access.log

                # A. KONDISI PERINGATAN (BELUM MENCAPAI BATAS)
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
♨ Harap patuhi aturan server ♨
"
                    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
                
                # B. KONDISI EKSEKUSI SANKSI
                elif [ "$pelanggaran_ke" -ge "$limit_notif" ]; then
                    exp=$(grep -wE "^${tag_grpc} $usr" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
                    uuid=$(grep -wE "^${tag_grpc} $usr" "/etc/xray/config.json" | cut -d ' ' -f 4 | sort | uniq)

                    # --- MODE AUTO LOCK ---
                    if [ "$type" == "lock" ]; then
                        echo "### $usr $exp $uuid" >> ${dir_conf}/listlock
                        sed -i "/^${tag_grpc} $usr $exp/,/^},{/d" /etc/xray/config.json
                        sed -i "/^${tag_id} $usr $exp/,/^},{/d" /etc/xray/config.json
                        
                        M=$(date -d "$waktulock minutes" +%M); H=$(date -d "$waktulock minutes" +%H)
                        echo "$M $H * * * root /usr/bin/xray $protocol $usr $uuid $exp && rm -f /etc/cron.d/xray_${protocol}_${usr}" > /etc/cron.d/xray_${protocol}_${usr}
                        TINDAKAN="DIKUNCI SEMENTARA ($waktulock Menit)"

                    # --- MODE AUTO DELETE ---
                    elif [ "$type" == "delete" ]; then
                        sed -i "/^${tag_grpc} $usr $exp/,/^},{/d" /etc/xray/config.json
                        sed -i "/^${tag_id} $usr $exp/,/^},{/d" /etc/xray/config.json
                        TINDAKAN="DIHAPUS PERMANEN"

                    # --- MODE SANKSI BERTINGKAT ---
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

                    # NOTIFIKASI SANKSI
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
♨ Sistem memutus akses akun tersebut ♨
"
                    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT_SANKSI&parse_mode=html" $URL >/dev/null
                    
                    rm -rf ${dir_conf}/${usr}login
                    
                    # Tandai agar Xray direstart di akhir script
                    RESTART_XRAY=1
                fi
            fi
        done
    fi
}

# ---------------------------------------------------------
# JALANKAN SEMUA PROTOKOL
# ---------------------------------------------------------
process_xray "vmess" "#vm" "#vmg"
process_xray "vless" "#vl" "#vlg"
process_xray "trojan" "#tr" "#trg"

# ---------------------------------------------------------
# RESTART XRAY HANYA JIKA ADA PELANGGARAN
# ---------------------------------------------------------
if [[ "$RESTART_XRAY" -eq 1 ]]; then
    systemctl restart xray >/dev/null 2>&1
fi
