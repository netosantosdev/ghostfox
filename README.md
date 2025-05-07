# 🦊 Ghostfox v3

Ghostfox v3 é um contêiner Docker seguro que encapsula um navegador Chromium isolado por uma conexão VPN via OpenVPN. Ele foi desenvolvido para oferecer privacidade, fluidez e usabilidade ao navegar em sites sensíveis ou com conteúdo restrito por localização, sem comprometer o desempenho.

## 📦 Estrutura Técnica

- **Sistema base:** Debian 11
- **Navegador:** Chromium
- **Interface gráfica:** TurboVNC + Openbox
- **Gerenciador de sessão:** Supervisor
- **Conexão segura:** OpenVPN
- **Transporte gráfico:** VNC (porta padrão 59000)
- **Rota de fallback (em planejamento):** Acesso web opcional via XPRA ou noVNC
- **Rota secundária (planejada):** Acesso à interface VNC via rede local (sem VPN)

## 🛡️ Privacidade e Flexibilidade

O Ghostfox v3 foi desenhado para desacoplar o uso do serviço VPN de qualquer provedor específico. Para isso, basta fornecer um arquivo `.ovpn` compatível com o OpenVPN (como Surfshark, NordVPN, etc.) e um arquivo `credentials.txt` contendo usuário e senha.

- ✅ Compatível com múltiplos provedores de VPN
- ✅ Suporte a `auth-user-pass` via arquivos
- ✅ Navegação totalmente isolada
- ✅ Sem dependência do sistema host

## 🚀 Principais Casos de Uso

- Navegação privada ou geolocalizada
- Acesso a sites bloqueados por IP
- Uso corporativo para análise externa segura
- Ambientes de teste de publicidade

## 📁 Organização esperada de diretórios

```
ghostfox-v3/
├── Dockerfile
├── supervisord.conf
├── start.sh
├── vpn_connect.sh
├── openvpn-config/
│   ├── credentials.txt
│   └── seu_arquivo.ovpn
├── chromium-profile/
└── README.md
```

## 🤝 Créditos

Projeto por [netosantosdev]
