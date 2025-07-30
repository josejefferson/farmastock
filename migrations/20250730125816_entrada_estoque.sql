-- +goose Up
CREATE TABLE IF NOT EXISTS entradas_estoque (
    id TEXT PRIMARY KEY,                
    produto_id TEXT NOT NULL,
    fornecedor TEXT NOT NULL,
    quantidade INTEGER NOT NULL,
    preco_custo_unitario REAL NOT NULL,
    preco_venda_unitario REAL NOT NULL,
    data_validade TEXT, 
    data_entrada TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (produto_id) REFERENCES produtos(id),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- +goose Down
DROP TABLE IF EXISTS entradas_estoque;
