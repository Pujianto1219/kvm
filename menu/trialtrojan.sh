#!/bin/bash
user2=$(grep -wE "^#trg $user" "/etc/xray/config.json" | cut -d ' ' -f 2 | sort | uniq)
exp=$(grep -wE "^#trg $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)

if [ $user2 = $user ]; then
        cd
        sed -i "/^#tr $user $exp/,/^},{/d" /etc/xray/config.json
        sed -i "/^#trg $user $exp/,/^},{/d" /etc/xray/config.json
        rm -rf /home/vps/public_html/trojan-$user.txt
        rm -rf /etc/trojan/${user}IP
        rm -rf /etc/trojan/${user}login
        rm -rf /etc/cron.d/trialtrojan$user
        systemctl restart xray
        fi