#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "Anda perlu menjalankan skrip ini sebagai root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ tidak didukung"
		exit 1
fi
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
# Link Hosting Kalian Untuk SSH VPN
sanivpn="raw.githubusercontent.com/yukik4ze/friedbanana/main/ssh"
# Link Hosting Kalian Untuk SSTP
sanivpnsstp="raw.githubusercontent.com/yukik4ze/friedbanana/main/sstp"
# Link Hosting Kalian Untuk SSR
sanivpnssr="raw.githubusercontent.com/yukik4ze/friedbanana/main/ssr"
# Link Hosting Kalian Untuk Shadowsocks
sanivpnshadowsocks="raw.githubusercontent.com/yukik4ze/friedbanana/main/shadowsocks"
# Link Hosting Kalian Untuk Wireguard
sanivpnwireguard="raw.githubusercontent.com/yukik4ze/friedbanana/main/wireguard"
# Link Hosting Kalian Untuk XRAY
sanivpnxray="raw.githubusercontent.com/yukik4ze/friedbanana/main/xray"
# Link Hosting Kalian Untuk IPSec
sanivpnipsec="raw.githubusercontent.com/yukik4ze/friedbanana/main/ipsec"
# Link Hosting Kalian Untuk Backup
sanivpnbackup="raw.githubusercontent.com/yukik4ze/friedbanana/main/backup"
# Link Hosting Kalian Untuk WebSocket
sanivpnwebsocket="raw.githubusercontent.com/yukik4ze/friedbanana/main/websocket"
# Link Hosting Kalian Untuk OHP
sanivpnohp="raw.githubusercontent.com/yukik4ze/friedbanana/main/ohp"

# Persiapan VPS
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Memeriksa VPS"
IZIN=$(wget -qO- ipinfo.io/ip);

rm -f setup.sh
clear
if [ -f "/etc/xray/domain" ]; then
echo "Script Telah Dipasang"
exit 0
fi
mkdir /var/lib/sanistorevpn;
echo "IP=" >> /var/lib/sanistorevpn/ipvps.conf
wget https://${sanivpn}/cf.sh && chmod +x cf.sh && ./cf.sh
#install ssh ovpn
wget https://${sanivpn}/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
wget https://${sanivpnbackup}/set-br.sh && chmod +x set-br.sh && ./set-br.sh
# Websocket
wget https://${sanivpnwebsocket}/edu.sh && chmod +x edu.sh && ./edu.sh
# Ohp Server
wget https://${sanivpnohp}/ohp.sh && chmod +x ohp.sh && ./ohp.sh

rm -f /root/ssh-vpn.sh
rm -f /root/set-br.sh
rm -f /root/edu.sh
rm -f /root/ohp.sh
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=thethemythwashere

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
wget -O /etc/set.sh "https://${sanivpn}/set.sh"
chmod +x /etc/set.sh
history -c
echo "1.2" > /home/ver
echo " "
echo "Pemasangan telah selesai!!"echo " "
echo "============================================================================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "----------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 443, 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 990"  | tee -a log-install.txt
echo "   - Stunnel5                : 443, 445, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 443, 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 89"  | tee -a log-install.txt
echo "   - Wireguard               : 7070"  | tee -a log-install.txt
echo "   - L2TP/IPSEC VPN          : 1701"  | tee -a log-install.txt
echo "   - PPTP VPN                : 1732"  | tee -a log-install.txt
echo "   - SSTP VPN                : 444"  | tee -a log-install.txt
echo "   - Shadowsocks-R           : 443, 80"  | tee -a log-install.txt
echo "   - SS-OBFS TLS             : 443"  | tee -a log-install.txt
echo "   - SS-OBFS HTTP            : 80"  | tee -a log-install.txt
echo "   - XRAYS Vmess TLS         : 443"  | tee -a log-install.txt
echo "   - XRAYS Vmess None TLS    : 80"  | tee -a log-install.txt
echo "   - XRAYS Vless TLS         : 443"  | tee -a log-install.txt
echo "   - XRAYS Vless None TLS    : 80"  | tee -a log-install.txt
echo "   - XRAYS Trojan            : 443"  | tee -a log-install.txt
echo "   - Websocket TLS           : 443"  | tee -a log-install.txt
echo "   - Websocket None TLS      : 80"  | tee -a log-install.txt
echo "   - Websocket Ovpn          : 443"  | tee -a log-install.txt
echo "   - OHP SSH                 : 8181"  | tee -a log-install.txt
echo "   - OHP Dropbear            : 8282"  | tee -a log-install.txt
echo "   - OHP OpenVPN             : 8383"  | tee -a log-install.txt
echo "   - Trojan Go               : 443"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo " Menyalakan ulang 15 detik"
sleep 15
rm -f setup.sh
reboot
