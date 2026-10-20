# 🐘 Guia Prático: Laravel & Laravel Sail

Um guia direto e descomplicado para criar e desenvolver aplicações com **Laravel** no **Arch Linux**, utilizando o **Laravel Sail** para isolar todo o ambiente de desenvolvimento em containers Docker sem poluir sua máquina física.

---

## 🎯 Por que Laravel Sail?

O [Laravel Sail](https://laravel.com/docs/sail) é uma interface de linha de comando leve desenvolvida pela própria equipe do Laravel para interagir com o ambiente Docker pré-configurado do framework.

### O problema do ambiente local tradicional

Para rodar Laravel "na lata", você precisa instalar e manter na sua máquina:

- **PHP** e dezenas de extensões (`mbstring`, `pdo_mysql`, `bcmath`, `xml`, `curl`...)
- **Composer** e **Node.js**
- **Bancos de dados e serviços auxiliares** (MySQL/PostgreSQL, Redis, servidor de e-mail de teste)

No **Arch Linux** isso piora por ser *rolling release*: o PHP do sistema sempre avança para a versão mais recente. Se um projeto exigir PHP 8.2 e outro PHP 8.4, manter várias versões e extensões lado a lado vira dor de cabeça, e uma atualização do sistema pode quebrar um projeto que funcionava ontem.

### Como o Sail resolve isso

1. **Zero poluição no seu computador:** nada de PHP, Composer ou banco de dados instalados no sistema. Quando não estiver programando, basta rodar `sail stop` e nenhum serviço consome RAM.
2. **Isolamento por projeto:** cada projeto tem seu próprio `docker-compose.yml`, então um pode usar PHP 8.2 + MySQL e outro PHP 8.4 + PostgreSQL, sem conflito de versões ou portas.
3. **Fim do "na minha máquina funciona":** toda a equipe (e o servidor de homologação) roda exatamente as mesmas versões das dependências.
4. **Serviços prontos com um parâmetro:** Redis, Meilisearch, Mailpit (para testar e-mails sem enviar de verdade) e Selenium já vêm integrados ao `.env`, sem configuração manual.
5. **Comandos simples:** em vez de `docker compose exec laravel.test php artisan migrate`, você digita só `sail artisan migrate`.

::: tip 💡 Vantagens do Sail
- **Zero poluição no seu computador:** Você não precisa instalar PHP, Composer, MySQL, PostgreSQL, Redis ou Node.js diretamente no seu sistema operacional.
- **Ambiente idêntico:** Toda a equipe e servidores de homologação rodam nas mesmas versões exatas de dependências.
- **Pronto para produção:** Inclui serviços modernos como Mailpit (para testar envio de emails localmente sem disparar de verdade), Redis, Meilisearch e Selenium.
:::

::: warning ⚖️ Quando o Sail pode não valer a pena
Containers consomem um pouco mais de disco e memória do que rodar nativamente, e o primeiro `sail up` baixa imagens grandes. Em máquinas muito limitadas, ou se você só mantém um único projeto com versões fixas, o ambiente nativo pode ser suficiente.
:::

---

## 📋 Pré-requisitos (Docker no Arch Linux)

Para utilizar o Sail, você só precisa do **Docker** e **Docker Compose** instalados e com o serviço em execução.

### 1. Instalando o Docker:

```bash
sudo pacman -S docker docker-compose
```

### 2. Ativando o serviço do Docker:

```bash
sudo systemctl enable --now docker.service
```

### 3. Rodando sem sudo (Recomendado):

Adicione seu usuário ao grupo `docker` para executar comandos sem digitar `sudo` todas as vezes:

```bash
sudo usermod -aG docker $USER
```

::: warning ⚠️ Sessão de Usuário
Após executar o comando acima, faça logout e login novamente (ou reinicie o computador) para que as novas permissões do grupo tenham efeito.
:::

---

## 🚀 Criando um Novo Projeto com Sail

Você não precisa ter o PHP nem o Composer instalados no seu Arch para iniciar um novo projeto! O script oficial do Laravel baixa os containers temporários para gerar a estrutura completa da aplicação.

### Criação Básica:

No terminal, vá até o diretório onde você organiza seus projetos (ex: `~/dev` ou `~/projetos`) e rode:

```bash
curl -s "https://laravel.build/meu-projeto" | bash
```

### Criação Escolhendo os Serviços:

Você pode customizar quais serviços acompanharão o projeto através do parâmetro `with`:

```bash
# Exemplo com MySQL, Redis e Mailpit:
curl -s "https://laravel.build/meu-projeto?with=mysql,redis,mailpit" | bash
```

Serviços suportados pelo instalador: `mysql`, `pgsql`, `mariadb`, `redis`, `memcached`, `meilisearch`, `typesense`, `minio`, `mailpit` e `selenium`.

---

## 🔌 Inicializando o Ambiente

Entre na pasta do projeto recém-criado:

```bash
cd meu-projeto
```

Suba todos os containers do Sail em segundo plano (*sem ocupar o terminal*):

```bash
./vendor/bin/sail up -d
```

::: info ⏳ Primeiro Boot
Na primeira vez que você executar o comando, o Docker baixará as imagens do PHP e dos serviços configurados. Isso pode demorar alguns minutos dependendo da sua velocidade de internet.
:::

Assim que os containers estiverem rodando, abra o seu navegador e acesse:
👉 `http://localhost`
Você verá a tela de boas-vindas do Laravel!

---

## ⚡ Configurando o Atalho (Alias) no Shell

Para não precisar digitar `./vendor/bin/sail` em todos os comandos, adicione o seguinte alias no seu shell favorito (`~/.zshrc` ou `~/.bashrc`):

```bash
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
```

Recarregue seu arquivo de configuração:
```bash
# Se usa Zsh:
source ~/.zshrc

# Se usa Bash:
source ~/.bashrc
```

Agora você pode simplesmente usar `sail` diretamente em qualquer pasta de projeto Laravel!

---

## 🛠️ Comandos Essenciais do Dia a Dia

Com o Sail rodando, execute qualquer comando do ecossistema do Laravel prefixando com `sail`:

### 1. Comandos do Artisan (CLI do Laravel)

```bash
# Listar todos os comandos disponíveis:
sail artisan list

# Executar as migrações do banco de dados:
sail artisan migrate

# Criar um Model com Migration, Controller e Factory:
sail artisan make:model Produto -mcrf

# Visualizar todas as rotas registradas:
sail artisan route:list

# Limpar caches de configuração e rotas:
sail artisan optimize:clear

# Abrir o Tinker (REPL interativo do Laravel):
sail artisan tinker
```

### 2. Gerenciando Dependências com o Composer

```bash
# Instalar uma nova biblioteca PHP:
sail composer require laravel/breeze

# Atualizar dependências:
sail composer update
```

### 3. Frontend com Vite & Node.js

O container do Sail também inclui Node e NPM:

```bash
# Instalar dependências JavaScript:
sail npm install

# Iniciar o servidor de desenvolvimento do Vite (HMR):
sail npm run dev

# Gerar o bundle de produção:
sail npm run build
```

### 4. Acessando o Banco de Dados

Conecte-se diretamente à linha de comando do banco de dados do container:

```bash
# Para MySQL / MariaDB:
sail mysql

# Para PostgreSQL:
sail psql
```

### 5. Executando Testes Automatizados

```bash
sail test
```

### 6. Parando os Containers

```bash
# Pausar os containers:
sail stop

# Parar e remover a rede do projeto:
sail down
```

---

## 📬 Visualizando E-mails em Desenvolvimento (Mailpit)

Se o seu projeto foi criado com o serviço `mailpit`, o Laravel já estará configurado no arquivo `.env` para direcionar todos os e-mails enviados para ele.

Para abrir o painel web de inspeção de emails, acesse no navegador:
👉 `http://localhost:8025`

---

## 💡 Dicas e Soluções de Problemas no Linux

### Conflito de Portas (ex: Porta 80 ou 3306 em uso)
Se você já tiver um Apache, Nginx ou MySQL rodando localmente na sua máquina, altere as portas no arquivo `.env` da raiz do seu projeto Laravel:

```dotenv
APP_PORT=8080
FORWARD_DB_PORT=3307
```
Depois recrie os containers:
```bash
sail down
sail up -d
```
E acesse `http://localhost:8080`.

### Executar bash dentro do container:
Caso precise depurar algo diretamente dentro do container PHP:
```bash
sail bash
```
Ou com privilégios de root dentro do container:
```bash
sail root-shell
```
