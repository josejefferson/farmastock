# Goose
Goose é uma ferramenta de migração de banco de dados escrita em Go. Ela permite que você crie, aplique e gerencie migrações de banco de dados de forma simples e eficiente.

## Instalação

Para instalar o Goose, você pode usar o comando:

```bash
    go install github.com/pressly/goose/v3/cmd/goose@latest```
```

Ou você pode baixar o binário diretamente do repositório do Goose no GitHub. Escolha a versão apropriada para o seu sistema operacional e arquitetura.

[➡ Goose Downloads](https://github.com/pressly/goose/releases)

## Configuração

> Para configurar o Goose, você precisa definir algumas variáveis de ambiente. Aqui está um exemplo de como configurar o Goose para usar um banco de dados SQLite:

```bash
export GOOSE_DRIVER=sqlite3
export GOOSE_DBSTRING=database.db
export GOOSE_MIGRATION_DIR=./migrations
```

Você também pode criar um arquivo `.env` na raiz do seu projeto com as seguintes variáveis de ambiente:

```env
GOOSE_DRIVER="sqlite3"
GOOSE_DBSTRING="database.db"
GOOSE_MIGRATION_DIR="./migrations"
```

## Migrations

As migrações são armazenadas na pasta `migrations` do seu projeto. Cada migração é um arquivo SQL que contém as instruções para modificar o banco de dados.

## Uso

```bash
    goose create <nome> sql # Cria um novo arquivo de migração
    goose status # Mostra o status das migrações
    goose up # Aplica todas as migrações pendentes
    goose down # Reverte a última migração aplicada
    goose up-to <versao> # Aplica migrações até a versão especificada
    goose redo # Reaplica a última migração
    goose reset # Reverte todas as migrações aplicadas
```

## Seed
As seeds são usadas para popular o banco de dados com dados iniciais. Nesse projeto, as seeds estão localizadas na pasta `migrations/seed`.

```bash
    goose goose -dir ./migrations/seed/ up
```