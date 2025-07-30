-- +goose Up
CREATE TABLE IF NOT EXISTS saidas_estoque (
    id TEXT PRIMARY KEY,
    produto_id TEXT NOT NULL,
    tipo_saida TEXT NOT NULL CHECK (tipo_saida IN ('Venda', 'Perda', 'Uso Interno')),
    quantidade INTEGER NOT NULL,
    preco_custo_unitario REAL NOT NULL,
    preco_venda_unitario REAL,
    data_saida TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (produto_id) REFERENCES produtos(id),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- +goose Down
DROP TABLE IF EXISTS saidas_estoque;
