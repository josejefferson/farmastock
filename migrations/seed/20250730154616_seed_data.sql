-- +goose Up
DELETE FROM saidas_estoque;
DELETE FROM entradas_estoque;
DELETE FROM produtos;
DELETE FROM dados_farmacia;
DELETE FROM usuarios;

INSERT INTO usuarios (id, nome, email, senha, role) VALUES
('049fdcbe-43e8-4cf0-b7f2-f6219a2cfbdc', 'Marcos Paulo', 'marcos.paulo@gmail.com', '$2a$12$hXdC4ptHb.rWjC57TwLiK./mCPjwftWxGtQSGnk5TgnF/bt33OGlu', 'admin'),
('e6066704-3bd3-4832-9d2b-219f3f063324', 'Kayo Ronald', 'kayoronald@gmail.com', '$2a$12$bdP2qgw7QdPTR9A5GtMBJej3ocoyKKM5YyOPyVBmC0qGdkWM2MUV.', 'usuario'),
('2c2a8343-e774-460a-9447-c87b5c62c2b1', 'Jose Jefferson', 'jose.jefferson@gmail.com', '$2a$12$wypxwiT5kDjF6GzsFjBEfeTZnuH9UBds8gSKLnfC.YTRELt5rqS0C', 'usuario');

INSERT INTO dados_farmacia (id, nome_farmacia, cnpj, email, telefone) VALUES
('18a07a3c-7722-4722-a999-b04ac8ccd189', 'Drogaria Central', '12345678901234', 'contato@drogariacentral.com', '5583987654321');

INSERT INTO produtos (id, nome, codigo_barras, unidade_medida, quantidade_atual, quantidade_minima, preco_custo, preco_venda) VALUES
('0e600314-0df8-4904-b2a1-7f2ba8991d8a', 'Paracetamol 500mg', '7891234567890', 'mg', 150, 20, 5.50, 10.99),
('51c24224-4140-46d6-a92a-60bab0f5f000', 'Amoxicilina 250mg/5mL', '7890987654321', 'mL', 50, 10, 12.00, 25.50),
('7e1a6fcf-de65-4f05-a8d1-8ca1be140cd2', 'Band-aid Caixa c/ 10', '7892345678901', 'un.', 200, 50, 3.00, 6.50);

INSERT INTO entradas_estoque (id, produto_id, fornecedor, quantidade, preco_custo_unitario, preco_venda_unitario, data_validade) VALUES
('94e144bb-ed28-484b-887c-b44101b7d41c', '0e600314-0df8-4904-b2a1-7f2ba8991d8a', 'Farmaceutica ABC', 100, 4.00, 8.00, '2026-12-31'),
('ab220295-3a27-420a-a5ab-e9f9d47e605a', '51c24224-4140-46d6-a92a-60bab0f5f000', 'Quimica XYZ', 30, 10.00, 22.00, '2027-06-30');

INSERT INTO saidas_estoque (id, produto_id, tipo_saida, quantidade, preco_custo_unitario, preco_venda_unitario) VALUES
('bac66570-f162-4d97-8b34-3f8ad17cb772', '0e600314-0df8-4904-b2a1-7f2ba8991d8a', 'Venda', 10, 5.50, 10.99),
('11c3ed18-d56e-4259-90f6-e772896041bd', '7e1a6fcf-de65-4f05-a8d1-8ca1be140cd2', 'Uso Interno', 5, 3.00, NULL);