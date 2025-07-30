-- +goose Up
CREATE TABLE IF NOT EXISTS produtos (
    id TEXT PRIMARY KEY,                
    nome TEXT NOT NULL,
    codigo_barras TEXT UNIQUE,
    unidade_medida TEXT CHECK (unidade_medida IN ('mg', 'g', 'kg', 'mL', 'L', 'un.')),
    quantidade_atual INTEGER NOT NULL DEFAULT 0,
    quantidade_minima INTEGER NOT NULL DEFAULT 0,
    preco_custo REAL NOT NULL,
    preco_venda REAL NOT NULL
);


-- +goose Down
DROP TABLE IF EXISTS produtos;
