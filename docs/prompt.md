Atue como um especialista sênior em administração de sistemas Linux, segurança defensiva e redes. Preciso configurar do zero o ambiente de auditoria, controle parental e acesso remoto entre o meu MacBook (máquina de administração) e um computador com o Ubuntu 24.04 LTS (com interface GNOME visual) que será utilizado por um adolescente.

PREMISSAS DO AMBIENTE:
- O computador terá duas contas: a minha (Administrador com privilégios sudo) e a do adolescente (Usuário Padrão, SEM privilégios sudo). Isso é crucial para que ele não desative os monitoramentos.
- O acesso remoto será feito a partir do meu MacBook, tanto por terminal quanto por interface gráfica.

Gostaria de um guia passo a passo prático, detalhado e com os comandos exatos para configurar as seguintes 5 camadas:

1. GERENCIAMENTO DE CONTAS E POLÍTICA DE PRIVILÉGIOS (Ubuntu)
- Comandos para criar a conta padrão do adolescente via terminal ou interface.
- Como garantir que arquivos críticos de configuração não possam ser alterados ou lidos por ele.

2. CONTROLE DE CONTEÚDO E MONITORAMENTO DE SITES (DNS Seguro na Raiz)
- Como configurar o Netplan no Ubuntu 24.04 para forçar o uso de um DNS com controle parental (ex: CleanBrowsing Family Filter ou OpenDNS).
- Como bloquear o arquivo /etc/resolv.conf ou travar as configurações de rede para impedir que o usuário padrão altere o DNS ou use ferramentas de bypass locais.

3. AUDITORIA DE SISTEMA E LOGS DE PROGRAMAS (Auditd e Zeek)
- Como instalar e configurar o 'auditd' para registrar no arquivo de log (/var/log/audit/audit.log) toda vez que um programa ou comando for executado (chamada de sistema execve).
- Como instalar o 'Zeek' para monitorar o tráfego de rede local e gerar logs legíveis de conexões (conn.log) e requisições de sites (dns.log).
- Forneça um exemplo prático de comando 'ausearch' para eu filtrar o que o adolescente abriu no computador.

4. ACESSO REMOTO SEGURO VIA TERMINAL E GRÁFICO (MacBook -> Ubuntu)
- No Ubuntu: Como ativar e blindar o servidor SSH (mudar a porta padrão 22, desativar login por senha 'PasswordAuthentication no' e permitir apenas chaves criptográficas).
- No MacBook: Como gerar o par de chaves SSH (ssh-keygen) e enviá-lo de forma segura para a conta admin do Ubuntu.
- No Ubuntu: Como ativar o compartilhamento de tela nativo via protocolo RDP no Ubuntu 24.04.
- No MacBook: Como configurar o aplicativo "Microsoft Remote Desktop" no macOS para conectar na interface gráfica do Ubuntu.

5. ACESSO REMOTO FORA DE CASA (RustDesk)
- Como configurar o RustDesk em ambas as máquinas para o cenário onde eu precise acessar o PC do meu filho enquanto eu estiver fora de casa (em redes Wi-Fi diferentes), mantendo a segurança de ponta a ponta.

Por favor, organize a resposta com markdown claro, separando os comandos que devem ser executados no terminal do Ubuntu daqueles que devem ser executados no terminal do Mac. Forneça explicações breves do que cada linha de comando faz.
