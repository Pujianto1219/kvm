#!/bin/bash
REPO="https://raw.githubusercontent.com/Pujianto1219/kvm/main/"
# (Atau sesuaikan REPO dengan URL repositori Anda yang aktif)

# 1. Mengunduh File Service Limit ke Systemd
wget -q -O /etc/systemd/system/limitvmess.service "${REPO}bin/limitvmess.service"
wget -q -O /etc/systemd/system/limitvless.service "${REPO}bin/limitvless.service"
wget -q -O /etc/systemd/system/limittrojan.service "${REPO}bin/limittrojan.service"

# 2. Mengunduh Skrip Limit Xray Core & SSH
wget -q -O /etc/xray/limit.vmess "${REPO}bin/vmess" >/dev/null 2>&1
wget -q -O /etc/xray/limit.vless "${REPO}bin/vless" >/dev/null 2>&1
wget -q -O /etc/xray/limit.trojan "${REPO}bin/trojan" >/dev/null 2>&1
wget -q -O /usr/bin/limit-ssh-quota "${REPO}bin/limit-ssh-quota" >/dev/null 2>&1

# 3. Memberikan Izin Eksekusi pada Skrip Limit
chmod +x /etc/xray/limit.vmess
chmod +x /etc/xray/limit.vless
chmod +x /etc/xray/limit.trojan
chmod +x /usr/bin/limit-ssh-quota

# 4. Mengaktifkan Cronjob untuk Limit SSH Quota
echo "# Autokill Quota SSH" > /etc/cron.d/limit-ssh-quota
echo "SHELL=/bin/sh" >> /etc/cron.d/limit-ssh-quota
echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" >> /etc/cron.d/limit-ssh-quota
echo "*/1 * * * * root /usr/bin/limit-ssh-quota" >> /etc/cron.d/limit-ssh-quota

# 5. Reload Daemon dan Mengaktifkan Service Secara Otomatis
systemctl daemon-reload
systemctl enable --now limitvmess
systemctl enable --now limitvless
systemctl enable --now limittrojan
systemctl restart cron >/dev/null 2>&1
