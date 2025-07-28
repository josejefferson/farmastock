-- +goose Up
-- +goose StatementBegin
CREATE OR REPLACE FUNCTION hash_usuarios_senha()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.senha IS DISTINCT FROM OLD.senha THEN
    NEW.senha := crypt(NEW.senha, gen_salt('bf', 12));
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- +goose StatementEnd

-- +goose Down
DROP FUNCTION IF EXISTS hash_usuarios_senha;
