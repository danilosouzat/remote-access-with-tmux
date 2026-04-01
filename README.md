# meuprojetoctl 🇧🇷
---

**Nome:** Danilo Souza Teixeira - Engenheiro de software  
**Versão do código:** 1.2  
**Linguagem:** Bash  
**Data do desenvolvimento:** 01/04/2026

---
# Projeto desenvolvido no Brasil 🇧🇷

---

**`meuprojetoctl`** é uma CLI em Bash para conectar em um servidor remoto via SSH e abrir sessões **`tmux`** prontas para trabalhar com um projeto Rails, com suporte a múltiplos ambientes, múltiplos painéis, listagem, status, limpeza automática e autocomplete.

## Importante

Este repositório usa nomes e dados **genéricos** para servir como modelo público.

Antes de usar em um projeto real, substitua:

- `ubuntu@00.000.00.000` pelo IP ou host real do seu servidor remoto
- `meuprojeto` pelo nome real do seu projeto
- `meuprojetoctl` pelo nome que você quiser dar ao seu CLI, se preferir

Exemplos:

```bash
REMOTE_HOST="ubuntu@192.168.10.50"
```

```bash
REMOTE_HOST="ubuntu@meu-servidor.exemplo.com"
```

Se o nome do seu projeto real for `billing`, você pode trocar:

- `meuprojetoctl` -> `billingctl`
- `meuprojeto` -> `billing`

## O que a ferramenta faz

- Conecta no servidor remoto via SSH
- Abre uma sessão `tmux` nova ou reconecta na última sessão
- Organiza sessões por ambiente: `prod`, `staging` e `dev`
- Abre múltiplos painéis no `tmux`:
  - Rails console
  - log em tempo real
  - shell no diretório do projeto
- Lista sessões existentes
- Mostra um resumo com `status`
- Limpa sessões antigas automaticamente
- Oferece menu interativo
- Suporta autocomplete no Bash

## Comandos disponíveis

```bash
meuprojetoctl help
meuprojetoctl menu
meuprojetoctl list [all|prod|staging|dev]
meuprojetoctl status [all|prod|staging|dev]
meuprojetoctl new [prod|staging|dev]
meuprojetoctl attach [prod|staging|dev]
meuprojetoctl clean [all|prod|staging|dev] [dias] [yes]
meuprojetoctl log [prod|staging|dev]
meuprojetoctl console [prod|staging|dev]
meuprojetoctl shell [prod|staging|dev]
meuprojetoctl completion
```

## Atalhos

```bash
meuprojetoctl prod
meuprojetoctl staging
meuprojetoctl dev
meuprojetoctl list
meuprojetoctl status
meuprojetoctl menu
meuprojetoctl clean all
meuprojetoctl log prod
meuprojetoctl console prod
meuprojetoctl shell prod
```

## Como usar no dia a dia

### Produção

```bash
meuprojetoctl prod
```

Isso tenta abrir a última sessão de produção. Se não existir nenhuma, cria uma nova.

### Staging

```bash
meuprojetoctl staging
```

Cria uma nova sessão de staging.

### Desenvolvimento

```bash
meuprojetoctl dev
```

Cria uma nova sessão de desenvolvimento.

### Listar sessões

```bash
meuprojetoctl list
```

### Ver status

```bash
meuprojetoctl status
```

### Abrir o menu interativo

```bash
meuprojetoctl menu
```

Isso irá retornar a seguinte saída:

```bash
meuprojetoctl console [prod|staging|dev]
meuprojetoctl log [prod|staging|dev]
meuprojetoctl shell [prod|staging|dev]
```

Exemplos práticos:

```bash
meuprojetoctl log prod
meuprojetoctl console prod
meuprojetoctl shell prod
```


O que cada um faz

`log prod` => abre a última sessão de produção com foco no painel do log.
`console prod` => abre a última sessão de produção com foco no Rails console.
`shell prod` =>  abre a última sessão de produção com foco no shell do projeto.


### Limpar todas as sessões

```bash
meuprojetoctl clean all
```

## Requisitos

No computador local:

- `bash`
- `ssh`
- suporte a `bash completion`

No servidor remoto:

- `tmux`
- `rvm`
- Ruby e as dependências do projeto
- acesso SSH funcionando


## Verificando se o tmux está instalado

Este projeto depende do `tmux` tanto no computador local quanto no servidor remoto.

Se o `tmux` não estiver instalado em qualquer um dos dois lados, a ferramenta não vai funcionar corretamente.

### 1. Verificar no computador local

Execute no seu terminal:

`tmux -V`


Se o tmux estiver instalado, você verá algo parecido com:

`tmux 3.3a`

Se o comando não for encontrado, instale com:

```bash
sudo apt update
sudo apt install tmux
```

### 2. Verificar no servidor remoto

Entre no servidor via SSH e execute:

```bash
ssh ubuntu@SEU_IP_OU_HOST
tmux -V
```


Se estiver instalado, a saída será parecida com:

`tmux 3.3a`

Se não estiver instalado no servidor, rode:

```bash
sudo apt update
sudo apt install tmux
```

### 3. Validar o funcionamento antes de usar o projeto

```bash
tmux -V
ssh ubuntu@SEU_IP_OU_HOST "tmux -V"
```


**Se ambos responderem com a versão do tmux, o ambiente está pronto para usar o projeto.**

---


## Instalação em um novo computador Linux

### 1. Baixe o projeto do GitHub

```bash
git clone https://github.com/SEU_USUARIO/meuprojetoctl.git
cd meuprojetoctl
```

### 2. Instale o script no PATH

```bash
sudo cp meuprojetoctl /usr/local/bin/meuprojetoctl
sudo chmod +x /usr/local/bin/meuprojetoctl
```

### 3. Ative o autocomplete

Adicione esta linha ao final do arquivo `~/.bashrc`:

```bash
source <(meuprojetoctl completion)
```

Depois recarregue o shell:

```bash
source ~/.bashrc
```

### 4. Teste a instalação

```bash
meuprojetoctl help
```

Se a ajuda aparecer corretamente, a instalação está pronta.

---

## Sessão Bonus!
### 🔐 Seção 1 — Configurar chave SSH


### Configurando acesso SSH sem senha

Para facilitar o uso da ferramenta, é altamente recomendado configurar acesso SSH sem precisar digitar senha.

### 1. Verificar se já existe uma chave SSH

No seu computador local:

```bash
ls ~/.ssh/id_rsa.pub
```

Se o arquivo existir, você já tem uma chave e pode pular para o passo 3.


### 2. Gerar uma nova chave SSH

`ssh-keygen -t rsa -b 4096 -C "seu-email@exemplo.com"`


Pressione `Enter` para aceitar os padrões.

### 3. Copiar a chave para o servidor

`ssh-copy-id ubuntu@SEU_IP_OU_HOST`

Exemplo:

`ssh-copy-id ubuntu@192.168.0.10`


### 4. Testar conexão sem senha

`ssh ubuntu@SEU_IP_OU_HOST`

Se entrar direto, sem pedir senha, está funcionando corretamente ✅

## Como instalar depois em outro computador

Quando for configurar em um novo Linux, o fluxo fica assim:

```bash
git clone https://github.com/SEU_USUARIO/meuprojetoctl.git
cd meuprojetoctl
sudo cp meuprojetoctl /usr/local/bin/meuprojetoctl
sudo chmod +x /usr/local/bin/meuprojetoctl
echo 'source <(meuprojetoctl completion)' >> ~/.bashrc
source ~/.bashrc
```

Depois, basta testar:

```bash
meuprojetoctl prod
```

## Configuração importante

### Ajustar o host remoto

No script, existe uma linha parecida com esta:

```bash
REMOTE_HOST="ubuntu@00.000.00.000"
```

Substitua esse valor pelo host real do seu servidor remoto.

Exemplo:

```bash
REMOTE_HOST="ubuntu@192.168.0.10"
```

ou


```bash
REMOTE_HOST="ubuntu@meu-servidor.com"
```


### Configurar diretório do projeto. Ajustar diretório, gemset ou Rails env

Se o projeto remoto mudar de caminho ou ambiente, ajuste estas estruturas no script:

- `APP_DIR`
- `GEMSET`
- `RAILS_ENV`
- `LOG_FILE`

### Configurar diretório do projeto
Ajuste os caminhos conforme o seu projeto.

```bash
declare -A APP_DIR=(
  [prod]="/home/ubuntu/apps/meuprojeto/current"
  [staging]="/home/ubuntu/apps/meuprojeto/current"
  [dev]="/home/ubuntu/apps/meuprojeto/current"
)
```

### Configurar gemset (RVM)

```bash
declare -A GEMSET=(
  [prod]="meuprojeto"
  [staging]="meuprojeto"
  [dev]="meuprojeto"
)
```

### Configurar ambiente Rails

```bash
declare -A RAILS_ENV=(
  [prod]="production"
  [staging]="staging"
  [dev]="development"
)
```


### Configurar logs

```bash
declare -A LOG_FILE=(
  [prod]="log/production.log"
  [staging]="log/staging.log"
  [dev]="log/development.log"
)
```

### ✅ Após configurar


```bash
meuprojetoctl prod
```

Se tudo estiver correto, a sessão tmux será criada automaticamente.

---


### Ajustar o nome da ferramenta

Este exemplo usa `meuprojetoctl` como nome genérico. Se o nome do seu projeto real for outro, você pode mudar tudo de forma consistente.

Exemplo:

- `meuprojetoctl` -> `billingctl`
- `meuprojeto` -> `billing`

## Dicas de uso

- `meuprojetoctl prod` é o comando mais prático para o trabalho diário.
- `meuprojetoctl status` ajuda a entender rapidamente quantas sessões existem.
- `meuprojetoctl clean all` remove todas as sessões do servidor gerenciadas por essa ferramenta.
- O `tmux` permite manter a sessão viva mesmo se a conexão SSH cair.

## Solução de problemas

### O comando não é encontrado

Verifique se o arquivo está em `/usr/local/bin/meuprojetoctl` e se está executável:

```bash
ls -l /usr/local/bin/meuprojetoctl
```

### O autocomplete não funciona

Confira se a linha abaixo está no `~/.bashrc`:

```bash
source <(meuprojetoctl completion)
```

Depois rode:

```bash
source ~/.bashrc
```

### O SSH não conecta

Teste o acesso manualmente:

```bash
ssh ubuntu@00.000.00.000
```

Depois substitua esse exemplo pelo endereço real do servidor.

### O `tmux` não existe no servidor

Instale no servidor remoto:

```bash
sudo apt update
sudo apt install tmux
```

## Licença

Use como referência pessoal ou adapte para o seu fluxo de trabalho.

## Autor

Projeto pessoal para facilitar acesso remoto ao Rails console com `tmux`.
