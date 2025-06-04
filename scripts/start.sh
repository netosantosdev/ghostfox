#!/bin/bash

# Detecta o gateway da rede Docker (interface eth0)
DOCKER_GATEWAY=$(ip route | awk '/default/ && /eth0/ {print $3}')
# Define a rede local a ser roteada (ajuste se necessário)
LOCAL_NETWORK="192.168.0.0/24"

# Adiciona a rota de retorno para manter acesso VNC mesmo com VPN ativa
echo "[start.sh] Adicionando rota local para $LOCAL_NETWORK via $DOCKER_GATEWAY"
ip route add "$LOCAL_NETWORK" via "$DOCKER_GATEWAY" || echo "[start.sh] Rota já existente ou falha ignorável"

echo "[start.sh] Aguardando servidor X (:2)..."
until xdpyinfo -display :2 >/dev/null 2>&1; do
        sleep 1
done

echo "[start.sh] Servidor X disponível. Iniciando Chromium..."

chromium \
        --no-sandbox \
        --disable-gpu \
        --disable-software-rasterizer \
        --disable-dev-shm-usage \
        --start-maximized \
        --load-extension=/root/extensions/ghost-stealth \
        --password-store=basic \
        --user-data-dir=/root/.config/chromium \
        "https://ipm.com.br" &

if [ ! -f /root/.vnc/passwd ]; then
        echo "[start.sh] Senha VNC não encontrada. Criando senha padrão..."
        echo "ghostfox" | /opt/TurboVNC/bin/vncpasswd -f > /root/.vnc/passwd
        chmod 600 /root/.vnc/passwd
fi

# Impede que o script morra e encerre o supervisor
tail -f /dev/null
