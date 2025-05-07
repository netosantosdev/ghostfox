#!/bin/bash

echo "[vpn_connect] Iniciando conexão com a VPN (OpenVPN)..."

/usr/sbin/openvpn \
  --config /etc/openvpn/vpn-config.ovpn \
  --auth-user-pass /etc/openvpn/credentials.txt \
  --persist-key \
  --persist-tun \
  --daemon \
  --log /var/log/openvpn.log

echo "[vpn_connect] Aguardando tun0..."
while ! ip a show tun0 > /dev/null 2>&1; do
  sleep 1
done

echo "[vpn_connect] VPN Conectada com sucesso!"

# Split tunneling: mantém o acesso externo ao container via porta 6081
GATEWAY=$(ip route | awk '/default/ { print $3 }')
ip route add 192.168.1.0/24 via $GATEWAY dev eth0

tail -f /var/log/openvpn.log
