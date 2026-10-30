#!/bin/bash

REPO="https://raw.githubusercontent.com/Pujianto1219/kvm/main/"

# ==========================================
# 1. Setup Limit Protocol Xray (Daemon)
# ==========================================
wget -q -O /etc/systemd/system/limitvmess.service "${REPO}bin/limitvmess.service" && chmod +x limitvmess.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limitvless.service "${REPO}bin/limitvless.service" && chmod +x limitvless.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limittrojan.service "${REPO}bin/limittrojan.service" && chmod +x limittrojan.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limitshadowsocks.service "${REPO}bin/limitshadowsocks.service" && chmod +x limitshadowsocks.service >/dev/null 2>&1

wget -q -O /etc/xray/limit.vmess "${REPO}bin/vmess" >/dev/null 2>&1
wget -q -O /etc/xray/limit.vless "${REPO}bin/vless" >/dev/null 2>&1
wget -q -O /etc/xray/limit.trojan "${REPO}bin/trojan" >/dev/null 2>&1
wget -q -O /etc/xray/limit.shadowsocks "${REPO}bin/shadowsocks" >/dev/null 2>&1

chmod +x /etc/xray/limit.vmess
chmod +x /etc/xray/limit.vless
chmod +x /etc/xray/limit.trojan
chmod +x /etc/xray/limit.shadowsocks

systemctl daemon-reload
systemctl enable --now limitvmess
systemctl enable --now limitvless
systemctl enable --now limittrojan
systemctl enable --now limitshadowsocks
# systemctl start limitvmess
# systemctl start limitvless
# systemctl start limittrojan
# systemctl start limitshadowsocks
# systemctl restart limitvmess
# systemctl restart limitvless
# systemctl restart limittrojan
# systemctl restart limitshadowsocks


# ==========================================
# 2. Setup AutoKill SSH Multi-Login (Cronjob)
# ==========================================
# Download file tendang.sh dari folder bin/
wget -q -O /usr/bin/tendang "${REPO}bin/tendang.sh"

# Konversi format ke Linux murni (mencegah bad interpreter)
dos2unix /usr/bin/tendang >/dev/null 2>&1

# Berikan hak akses eksekusi
chmod +x /usr/bin/tendang

# Daftarkan ke Cronjob agar berjalan setiap 1 menit secara otomatis
cat > /etc/cron.d/tendang_ssh << EOF
* * * * * root /usr/bin/tendang
EOF

# Restart layanan cron agar jadwal baru langsung dibaca
systemctl restart cron