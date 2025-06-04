# Ghostfox v4.3 - Dockerfile

# Base Image
FROM debian:11-slim

# Variáveis de Ambiente
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:2

# Instalação de Dependências
RUN apt-get update && apt-get install -y \
    xorg \
    fluxbox \
    chromium \
    openvpn \
    supervisor \
    curl \
    wget \
    unzip \
    gnupg \
    ca-certificates \
    x11-xserver-utils \
    xauth \
    libgl1-mesa-dri \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libatk1.0-0 \
    libgtk-3-0 \
    libasound2 \
    libnss3 \
    libxss1 \
    libxtst6 \
    libx11-xcb1 \
    fonts-liberation \
    xdg-utils \
    libjpeg-turbo-progs \
    libxfixes3 \
    libxcursor1 \
    libxinerama1 \
    libxshmfence1 \
    libegl1 \
    libgl1-mesa-glx \
    pulseaudio \
    dbus-x11 \
    net-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalação TurboVNC
RUN wget -qO /tmp/turbovnc.deb https://downloads.sourceforge.net/project/turbovnc/2.2.6/turbovnc_2.2.6_amd64.deb && \
    apt-get install -y /tmp/turbovnc.deb && \
    rm /tmp/turbovnc.deb

# Diretórios essenciais
RUN mkdir -p /etc/supervisor/conf.d /scripts /vpn /root/logs /root/.vnc

# Definir senha do VNC para root
RUN echo "devsc1" | /opt/TurboVNC/bin/vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

# Copiar arquivos do projeto
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY scripts/ /scripts/
COPY vpn/ /vpn/

RUN chmod +x /scripts/*.sh

# WORKDIR
WORKDIR /root

# Comando padrão
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
