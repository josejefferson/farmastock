-- +goose Up
-- +goose StatementBegin
CREATE TRIGGER before_update_usuarios_hash_senha
BEFORE INSERT OR UPDATE ON usuarios
FOR EACH ROW
EXECUTE FUNCTION hash_usuarios_senha();
-- +goose StatementEnd

-- +goose Down
DROP TRIGGER IF EXISTS before_update_usuarios_hash_senha;