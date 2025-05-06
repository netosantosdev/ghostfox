FROM debian:11-slim

ENV DISPLAY=:0

RUN apt update && apt install -y \
    curl gnupg lsb-release supervisor firefox-esr openbox x11vnc \
    xvfb xterm sudo wget ca-certificates dbus-x11 net-tools unzip \
    openvpn iputils-ping --no-install-recommends && \
    apt clean && rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh
COPY vpn_connect.sh /vpn_connect.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /start.sh /vpn_connect.sh

CMD ["/start.sh"]