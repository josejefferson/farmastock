-- +goose Up
INSERT INTO usuarios (nome, email, senha, role)
VALUES 
('Marcos Paulo', 'marcospaulo@email.com', 'marcos123', 'admin'),
('Kayo Ronald',  'kayoronald@email.com', 'kayo123', 'funcionario'),
('José Jefferson', 'josejefferson@email.com', 'jose123', 'funcionario');


-- +goose Down
DELETE FROM usuarios;