-- +goose Up
CREATE TABLE IF NOT EXISTS dados_farmacia (
    id TEXT PRIMARY KEY,                
    nome_farmacia TEXT NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    email TEXT,
    telefone CHAR(15),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- +goose Down
DROP TABLE IF EXISTS dados_farmacia;
