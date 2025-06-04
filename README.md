# Ghostfox v4.5

Ghostfox é um container Docker que oferece um ambiente seguro para navegação web via navegador Chromium, utilizando VPN e acesso remoto por VNC.

Esta versão é um **refinamento da v4.0**, com melhorias voltadas para robustez, estabilidade e replicabilidade sem conhecimento técnico por parte do usuário final.

---

## 🆕 Novidades da versão 4.5

- 🔁 **Xvnc no lugar de vncserver** para estabilidade no supervisord
- 🔐 **Execução como root**, eliminando problemas de permissões
- 🌐 **VPN continua utilizando arquivos `connection.ovpn` e `credentials.txt`**
- 🧠 **Rota local automática** adicionada no `start.sh` para manter o acesso ao VNC após conexão VPN
- 📦 **Estrutura mais limpa**, com logs centralizados em `/var/log`
- 🧩 **Extensão ghost-stealth**, Esconde sinais de automação do navegador e Spoof do Navigator

---

## 📦 Estrutura do Projeto

```plaintext
ghostfox-v4.3/
├── docker-compose.yml
├── Dockerfile
├── supervisord.conf
├── README.md
├── scripts/
│   ├── check_vpn.sh
│   └── start.sh
├── vpn/
│   ├── connection.ovpn
│   └── credentials.txt
├── extensions /
|    ├──  ghost-stealth /
|         └── background.js
|         └── content.js
|         └── manifest.json
```

---

## 🚀 Instalação e Execução

1. **Clone ou extraia o projeto**

```bash
git clone https://github.com/seuprojeto/ghostfox-v4.3.git
cd ghostfox-v4.3
```

2. **Adicione os arquivos de VPN**

- Coloque o seu `.ovpn` dentro da pasta `vpn/` como `connection.ovpn`
- Crie o arquivo `credentials.txt` contendo:
```
usuarioVPN
senhaVPN
```

3. **(Opcional) Ajuste a faixa de rede local**

No arquivo `scripts/start.sh`, altere a linha:
```bash
LOCAL_NETWORK="192.168.0.0/24"
```
> Substitua pela faixa da VLAN que usará para acessar o container (ex: `192.168.1.0/24` ou `10.0.0.0/24`)

4. **Build e execução**

```bash
docker compose build
docker compose up -d
```

5. **Acesso via VNC**

- IP: `localhost`
- Porta: `5901`
- Senha: `ghostfox`
- Protocolo: VNC Authentication (sem TLS)

---

## 🛠️ Requisitos

- Docker 20+
- docker-compose 1.27+
- Suporte a `/dev/net/tun` no host
- Permissões de `CAP_NET_ADMIN` ativadas no container

---

## 📌 Considerações Técnicas

- O uso do `Xvnc` evita falhas recorrentes de supervisão
- A adição automática da rota via gateway Docker evita que a VPN corte o acesso VNC
- O `start.sh` agora inclui lógica para detectar o gateway e aplicar a rota dinamicamente

---

## 📄 Licença

MIT - Desenvolvido com foco em automação e privacidade
