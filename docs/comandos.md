# 🐧 Guia Definitivo de Comandos Linux

Uma seleção prática dos comandos mais úteis e frequentes para o dia a dia no **Arch Linux** e sistemas baseados em Linux. Organizado por categorias para consulta rápida, produtividade no terminal e manutenção do sistema.

---

## 📦 1. Gerenciamento de Pacotes (Pacman & AUR / Paru)

No Arch Linux, o gerenciador padrão é o `pacman`, frequentemente acompanhado por um AUR helper moderno escrito em Rust como o `paru`.

### Atualização e Manutenção Básica

| Comando | Descrição |
| :--- | :--- |
| `sudo pacman -Syu` | Atualiza a base de dados dos repositórios oficiais e todos os pacotes instalados. |
| `paru` (ou `paru -Syu`) | Atualiza tanto os repositórios oficiais quanto o AUR (rodar apenas `paru` já executa o sync completo). |
| `paru -Sua` | Atualiza exclusivamente os pacotes vindos do AUR. |
| `sudo pacman -Syyu` | Força a atualização completa de todas as bases de dados (útil após trocar mirrors). |

### Instalação e Remoção

```bash
# Instalar um ou mais pacotes oficiais
sudo pacman -S nome_do_pacote

# Instalar pacote oficial ou do AUR via paru (busca em ambos automaticamente)
paru -S nome_do_pacote

# Remover pacote mantendo dependências
sudo pacman -R nome_do_pacote

# Remover pacote e suas dependências órfãs + arquivos de configuração não modificados (RECOMENDADO)
sudo pacman -Rns nome_do_pacote

# Remover dependências órfãs diretamente com o paru
paru -c
```

### Pesquisa e Informações

```bash
# Procurar um pacote nos repositórios oficiais
pacman -Ss termo_de_busca

# Procurar pacotes no repositório oficial e no AUR com interface interativa
paru termo_de_busca

# Procurar pacotes já instalados na sua máquina
pacman -Qs termo_de_busca

# Ver detalhes completos de um pacote (versão, dependências, tamanho)
pacman -Si nome_do_pacote

# Descobrir a qual pacote pertence um determinado arquivo no disco
pacman -Qo /caminho/do/arquivo
```

### Limpeza e Otimização do Sistema

::: tip 💡 Dica de Manutenção
Com o tempo, o cache do `pacman` e do `paru` acumulam versões antigas e ocupam gigabytes de disco.
:::

```bash
# Listar e remover pacotes órfãos (que não são mais necessários)
sudo pacman -Rns $(pacman -Qtdq)

# Limpar o cache mantendo apenas as 2 versões mais recentes (requer o pacote pacman-contrib)
sudo paccache -r

# Limpar cache de compilação e pacotes baixados pelo paru
paru -Sc

# Se o banco de dados do pacman travar por queda de energia ou fechamento inesperado
sudo rm /var/lib/pacman/db.lck
```

---

## 📁 2. Arquivos, Leitura e Navegação

### Operações Essenciais

| Comando | O que faz |
| :--- | :--- |
| `cd -` | Volta imediatamente ao diretório anterior. |
| `touch arquivo.txt` | Cria arquivo vazio ou atualiza o timestamp se já existir. |
| `mkdir -p pasta/subpasta` | Cria a árvore inteira de diretórios recursivamente sem erro. |
| `mv origem destino` | Move ou renomeia arquivos e pastas. |
| `cp -r origem/ destino/` | Copia diretório recursivamente preservando subpastas. |
| `rm -rf pasta/` | Remove diretórios e conteúdos recursivamente (**cuidado**). |
| `ln -s /origem /link` | Cria link simbólico (**essencial para gerenciar dotfiles em `~/.config/`**). |
| `rsync -avzhP origem/ destino/` | Cópia avançada com barra de progresso, retomada de falhas e integridade. |

### Leitura e Inspeção de Arquivos

```bash
# Paginar arquivos longos sem carregar tudo na memória (navegue com setas, / para buscar, q para sair)
less arquivo.log

# Ver as primeiras 20 linhas
head -n 20 arquivo.txt

# Ver as últimas 50 linhas
tail -n 50 arquivo.txt

# Acompanhar escrita de arquivo/log em tempo real
tail -f /var/log/pacman.log

# Descobrir o tipo real de um arquivo (não depende da extensão)
file arquivo_desconhecido

# Inspecionar metadados detalhados (permissões, dono, inode, tamanho, datas)
stat arquivo.txt

# Visualizar estrutura de diretórios em árvore limitando a profundidade
tree -L 2
```

### Busca Inteligente (Find, Fd, Grep e Ripgrep)

```bash
# Encontrar arquivos por nome (find tradicional)
find . -type f -name "*.conf"

# Alternativa moderna ultrarrápida: fd
fd -e conf

# Buscar texto dentro de arquivos em todo o projeto recursivamente (ripgrep)
rg "termo_procurado"

# Buscar texto ignorando maiúsculas/minúsculas
rg -i "termo"

# Busca interativa de arquivos com fuzzy finder (fzf)
fzf
```

### Permissões e Donos

```bash
# Alterar dono e grupo recursivamente
sudo chown -R usuario:grupo /caminho/pasta

# Permissões padrão recomendadas:
find /caminho/projeto -type d -exec chmod 755 {} + # Diretórios: leitura/execução
find /caminho/projeto -type f -exec chmod 644 {} + # Arquivos: leitura/escrita
chmod +x script.sh                                # Tornar um script executável
```

---

## 🔀 3. Pipes, Redirecionamentos e Processamento de Texto

A verdadeira força do terminal Linux está na composição de comandos encadeados.

### Redirecionamento de Fluxos

| Operador | Significado |
| :--- | :--- |
| `comando > saida.txt` | Redireciona `stdout` sobrescrevendo o arquivo. |
| `comando >> saida.txt` | Redireciona `stdout` anexando ao final do arquivo (*append*). |
| `comando 2> erro.log` | Redireciona apenas erros (`stderr`). |
| `comando &> tudo.log` | Redireciona tanto a saída padrão quanto os erros (`stdout` + `stderr`). |
| `comando1 \| comando2` | Conecta a saída do primeiro comando à entrada do segundo (*pipe*). |
| `comando \| tee saida.txt` | Exibe na tela e grava no arquivo simultaneamente. |

### Utilitários de Texto

```bash
# Filtrar linhas por padrão
grep "ERRO" app.log
grep -R "termo" src/

# Substituir ocorrências em arquivos ou streams (sed)
sed 's/porta_antiga/porta_nova/g' config.env

# Extrair colunas específicas (awk)
awk '{print $1, $3}' dados.txt

# Cortar campos por delimitador (ex: usernames em /etc/passwd)
cut -d: -f1 /etc/passwd

# Ordenar linhas alfabeticamente ou numericamente
sort arquivo.txt
sort -n numeros.txt

# Remover linhas duplicadas consecutivas e contar repetições
sort arquivo.txt | uniq -c

# Contar linhas (-l), palavras (-w) ou caracteres (-m)
wc -l arquivo.txt

# Executar comandos para cada linha recebida via stdin (xargs)
cat lista_ips.txt | xargs -n 1 ping -c 1
```

::: tip 💡 Exemplo de Pipeline no Mundo Real
Descobrir os erros mais frequentes em logs ordenados pela quantidade:
```bash
rg "error" *.log | sort | uniq -c | sort -nr | head -n 10
```
:::

---

## ⚡ 4. Processos, Monitoramento e Controle de Jobs

### Visualização do Sistema

- **`btop`**: Monitor interativo moderno com visualização de CPU, Memória, Discos e GPU.
- **`htop`**: O clássico e leve visualizador interativo em terminal.
- **`fastfetch`**: Exibe informações do sistema, kernel e hardware estilizadas.

### Localizando e Encerrando Processos

```bash
# Listar processos ativos filtrando por nome
ps aux | grep nome_do_processo

# Obter o PID direto de um processo
pgrep -f nome_do_processo

# Encerrar processo graciosamente (envia SIGTERM)
kill <PID>

# Forçar encerramento imediato de processo travado (envia SIGKILL)
kill -9 <PID>

# Encerrar todas as instâncias pelo nome
killall nome_do_processo
```

### Controle de Jobs em Segundo Plano

```bash
# Iniciar um processo já em background
meu_script.sh &

# Pausar o processo em execução na janela atual
Ctrl + Z

# Listar jobs pausados ou rodando em background no shell atual
jobs

# Trazer job de volta para o primeiro plano (foreground)
fg %1

# Deixar o job rodando em background liberando o terminal
bg %1

# Desvincular um processo do terminal para não morrer ao fechar
disown %1

# Executar um comando imune ao término da sessão do terminal
nohup python app.py > app.log 2>&1 &
```

::: tip 💡 Sessões Persistentes
Para manter processos rodando continuamente mesmo desconectando do terminal ou SSH, utilize o [tmux](https://github.com/tmux/tmux):
- `tmux new -s sessao`: cria sessão
- `Ctrl + B` seguido de `D`: desacopla (*detach*)
- `tmux attach -t sessao`: reconecta
:::

### Memória e Armazenamento

```bash
# Ver uso de memória RAM e Swap de forma legível
free -h

# Espaço livre nas partições de disco montadas
df -h

# Analisar quais pastas mais ocupam espaço no diretório atual
du -sh * | sort -h

# Visualizador interativo e leve de consumo de disco (requer ncdu)
ncdu
```

---

## ⚙️ 5. Serviços e Logs do Sistema (Systemd & Journalctl)

O `systemd` gerencia inicialização, daemons e serviços do sistema.

### Gerenciando Serviços (Systemctl)

```bash
# Verificar status de um serviço
systemctl status nome_servico

# Iniciar / Parar / Reiniciar serviço
sudo systemctl start nome_servico
sudo systemctl stop nome_servico
sudo systemctl restart nome_servico

# Habilitar para iniciar no boot do sistema
sudo systemctl enable nome_servico

# Habilitar e iniciar imediatamente em um único comando
sudo systemctl enable --now nome_servico

# Desabilitar da inicialização e parar imediatamente
sudo systemctl disable --now nome_servico

# Para serviços do usuário comum (sem sudo, ex: pipewire, waybar)
systemctl --user status nome_servico
systemctl --user restart nome_servico
```

### Diagnóstico de Falhas e Tempo de Boot

```bash
# Listar todos os serviços que falharam no sistema
systemctl --failed

# Analisar quais serviços tornaram o boot mais lento
systemd-analyze blame
```

### Leitura de Logs (Journalctl)

```bash
# Acompanhar logs do sistema em tempo real
journalctl -f

# Acompanhar logs de um serviço específico
journalctl -fu nome_servico

# Ver apenas os logs gerados desde o boot atual
journalctl -b

# Filtrar apenas erros graves e alertas críticos do boot atual
journalctl -p 3 -xb

# Ver os últimos 100 registros detalhados
journalctl -xe -n 100
```

---

## 🌐 6. Redes, Conectividade e Acesso Remoto (SSH)

### Interfaces e Wi-Fi

```bash
# Exibir interfaces e endereços IP de forma compacta
ip -br a

# Exibir tabela de roteamento (gateway padrão)
ip route

# Listar redes Wi-Fi disponíveis
nmcli device wifi list

# Conectar a uma rede Wi-Fi protegida via NetworkManager
nmcli device wifi connect "NomeDaRede" password "SuaSenha"

# Ver todas as conexões salvas
nmcli connection show
```

### Portas e Conexões Ativas

```bash
# Listar todas as portas TCP/UDP abertas e processos associados
ss -tulpn

# Descobrir qual processo específico está ocupando uma porta (ex: porta 8080)
sudo lsof -i :8080
# ou
sudo fuser 8080/tcp
```

### Testes, Diagnóstico e Downloads

```bash
# Testar conectividade e latência com limite de 4 pacotes
ping -c 4 1.1.1.1

# Inspecionar cabeçalhos HTTP de uma URL
curl -I https://archlinux.org

# Baixar arquivo preservando o nome original remoto
curl -O https://exemplo.com/arquivo.zip
wget https://exemplo.com/arquivo.zip

# Resolução DNS rápida
dig archlinux.org +short
```

### Acesso Remoto Seguro (SSH)

```bash
# Gerar par de chaves SSH moderno e seguro (Ed25519)
ssh-keygen -t ed25519 -C "seu_email@exemplo.com"

# Copiar sua chave pública para um servidor remoto (habilita login sem senha)
ssh-copy-id usuario@ip_do_servidor

# Conectar via SSH
ssh usuario@ip_do_servidor

# Copiar arquivo local para servidor remoto com SCP
scp arquivo.tar.gz usuario@ip_do_servidor:/var/www/

# Copiar pasta inteira recursivamente
scp -r pasta/ usuario@ip_do_servidor:~/backups/
```

---

## 🗜️ 7. Compactação e Descompactação

```bash
# Compactar pasta em .tar.gz
tar -czvf arquivo.tar.gz /caminho/pasta

# Extrair arquivo .tar.gz
tar -xzvf arquivo.tar.gz

# Extrair arquivo com compressão Zstandard (.tar.zst - padrão de pacotes do Arch)
tar -I zstd -xvf pacote.pkg.tar.zst

# Extrair arquivos .zip
unzip arquivo.zip -d pasta_destino/

# Criar arquivo .zip
zip -r arquivo.zip pasta/

# Extrair praticamente qualquer formato com 7z
7z x arquivo.7z
```

---

## 💽 8. Discos, Partições e Diagnóstico do Sistema

### Discos e Montagens

```bash
# Listar todos os discos, partições, pontos de montagem e sistemas de arquivos
lsblk -f

# Ver UUIDs de todas as partições (essencial para configurar o fstab)
sudo blkid

# Montar uma partição temporariamente
sudo mount /dev/nvme0n1p3 /mnt

# Desmontar com segurança
sudo umount /mnt

# Comparar diferenças entre dois arquivos
diff -u config_velha.conf config_nova.conf

# Calcular checksum SHA-256 para checar integridade de ISOs/arquivos
sha256sum imagem.iso
```

### Diagnóstico de Kernel e Hardware

```bash
# Versão exata do Kernel Linux ativo
uname -r

# Tempo de atividade do sistema e média de carga (load average)
uptime

# Usuário atual e identificadores (UID, GID e grupos adicionais)
whoami
id

# Mensagens do buffer do kernel em formato legível (ótimo para diagnosticar USBs e drivers)
dmesg -T | tail -n 50

# Inspecionar dispositivos PCI (GPU, NVMe, controladoras) e drivers carregados
lspci -k

# Inspecionar dispositivos USB conectados
lsusb

# Resumo completo do hardware (requer inxi)
inxi -Fz
```

---

## 🔍 9. Ajuda, Descoberta e Ambiente do Shell

Descubra como os comandos funcionam e gerencie suas variáveis de ambiente.

```bash
# Manual completo com paginação
man comando

# Ajuda rápida com as flags suportadas
comando --help

# Exemplos práticos do dia a dia (instale: paru -S tldr)
tldr rsync

# Exibir onde o comando está localizado ou se é alias/função
command -v comando
type comando
which comando

# Histórico de comandos digitados
history
history | grep "pacman"

# Definir e inspecionar variáveis de ambiente
export PROJETO_DIR="/home/usuario/dev"
env | grep PROJETO

# Recarregar as configurações do shell após editar dotfiles
source ~/.zshrc    # Zsh
source ~/.bashrc   # Bash
```

---

## 🚀 10. Atalhos de Produtividade no Terminal (Bash / Zsh)

Pequenos hábitos que economizam horas no dia a dia:

| Atalho / Truque | Função |
| :--- | :--- |
| `Ctrl + R` | Busca reversa e interativa no histórico de comandos digitados. |
| `sudo !!` | Executa o comando anterior com privilégios de `sudo` (caso tenha esquecido). |
| `Ctrl + A` | Move o cursor para o início absoluto da linha. |
| `Ctrl + E` | Move o cursor para o final da linha. |
| `Ctrl + U` | Apaga tudo do cursor até o início da linha. |
| `Ctrl + K` | Apaga tudo do cursor até o final da linha. |
| `Ctrl + W` | Apaga a palavra anterior antes do cursor. |
| `Ctrl + L` | Limpa a tela mantendo a linha atual (equivalente ao comando `clear`). |
| `ESC + .` | Cola o último argumento do comando anterior. |

::: tip 💡 Aliases Úteis para o seu `.zshrc`
Experimente adicionar apelidos rápidos para comandos recorrentes:
```bash
alias update='paru'
alias cls='clear'
alias c='clear'
alias ports='ss -tulpn'
alias myip='curl ifconfig.me'
alias orphans='sudo pacman -Rns $(pacman -Qtdq)'
alias ll='ls -lah --color=auto'
```
:::
