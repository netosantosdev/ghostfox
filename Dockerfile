# 1. Base compatível com XPRA
FROM debian:10-slim

ENV DISPLAY=:100

# 2. Adiciona repositório oficial XPRA e dependências de chave SSL
RUN apt update && apt install -y wget curl gnupg ca-certificates && \
    echo "deb https://xpra.org/ buster main" > /etc/apt/sources.list.d/xpra.list && \
    wget -q https://xpra.org/gpg.asc -O- | apt-key add -

RUN apt update && apt install -y \
    xpra xpra-html5 xpra-x11 \
    xserver-xorg-core xserver-xorg-video-dummy xauth \
    supervisor openbox midori \
    xterm sudo dbus-x11 net-tools unzip \
    openvpn iputils-ping --no-install-recommends && \
    apt clean && rm -rf /var/lib/apt/lists/*


# 4. Configuração do driver gráfico dummy
RUN mkdir -p /etc/X11/xorg.conf.d
COPY 10-xpra-dummy.conf /etc/X11/xorg.conf.d/10-xpra-dummy.conf

# 5. Scripts e config
COPY start.sh /start.sh
COPY vpn_connect.sh /vpn_connect.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /start.sh /vpn_connect.sh

CMD ["/start.sh"]

