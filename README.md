# 🛡 Navegador VPN com Docker + OpenVPN

Este projeto cria um contêiner Docker com Firefox isolado, roteado por VPN via OpenVPN, acessível através de VNC. Ele foi desenvolvido para tarefas como **criação de múltiplas contas online**, evitando bloqueios de IP por plataformas como a Meta.

## 🚀 Funcionalidades

- Firefox com interface gráfica via VNC (porta 5900)
- Conexão automática com qualquer VPN baseada em `.ovpn`
- Split tunneling: tráfego da aplicação roteado via VPN, mas acesso VNC permanece local
- Persistência de perfil do navegador
- Inicialização automática de todos os serviços com supervisord

## 🔄 Compatibilidade com qualquer VPN

Embora o projeto tenha sido desenvolvido e testado com Surfshark, você pode utilizar **qualquer serviço VPN** que forneça arquivos `.ovpn` compatíveis com o OpenVPN.

Por padrão, o arquivo de configuração esperado chama-se:
```
openvpn-config/vpn-config.ovpn
```
Se desejar usar outro nome, basta editar o caminho no arquivo `vpn_connect.sh`.

## 🛠️ Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/navegador-vpn.git
   cd navegador-vpn
   ```

2. Crie a pasta `openvpn-config/` e adicione os seguintes arquivos:
   - `vpn-config.ovpn` → arquivo de configuração OpenVPN
   - `credentials.txt` → com seu login e senha (2 linhas)

3. Suba o ambiente:
   ```bash
   docker compose up --build -d
   ```

4. Conecte via VNC:
   - IP do host
   - Porta: `5900`
   - Sem senha (ou configure uma manualmente via `x11vnc`)

## 📂 Estrutura do projeto

```
.
├── openvpn-config/         # Arquivo .ovpn + credentials.txt
├── navegador-profile/      # Perfil persistente do Firefox
├── docker-compose.yml
├── Dockerfile
├── vpn_connect.sh
├── start.sh
├── supervisord.conf
└── README.md
```

## 👤 Créditos

Desenvolvido por [netosantosdev](https://github.com/netosantosdev)

---
Para dúvidas ou melhorias, abra uma issue ou envie um pull request.