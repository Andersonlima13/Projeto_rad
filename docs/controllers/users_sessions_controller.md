### Users::SessionsController

Sobrescreve o `create` de sessões do Devise para customizar as mensagens e o redirecionamento.

#### Ações
- `create`
  - Autentica com o Warden (`warden.authenticate!`) e realiza o login do usuário
  - Sucesso: define flash `:notice` e redireciona para `after_sign_in_path_for(resource)` (dashboard)
  - Erro: faz rescue, define `flash.now[:alert] = "Falha no login: ..."` e renderiza `:new`

#### Rotas
Gerenciadas pelo Devise sob `/users`:
- `GET /users/sign_in`
- `POST /users/sign_in`
- `DELETE /users/sign_out`

#### Exemplo
```bash
curl -i -X POST -H "Content-Type: application/x-www-form-urlencoded" \
  -c cookies.txt -d "user[email]=you@example.com&user[password]=secret" \
  http://localhost:3000/users/sign_in
```