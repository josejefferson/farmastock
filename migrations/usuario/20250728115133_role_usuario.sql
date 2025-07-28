-- +goose Up
-- +goose StatementBegin
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'role_usuario') THEN
        CREATE TYPE role_usuario AS ENUM ('admin', 'funcionario');
    END IF;
END
$$;
-- +goose StatementEnd

-- +goose Down
DROP TYPE IF EXISTS role_usuario;