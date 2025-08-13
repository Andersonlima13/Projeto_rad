### Users::RegistrationsController

Estende os registros do Devise e permite parâmetros adicionais.

#### Filtros
- `before_action :configure_sign_up_params, only: :create`
- `before_action :configure_account_update_params, only: :update`

#### Parâmetros permitidos
```ruby
def configure_sign_up_params
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
end

def configure_account_update_params
  devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :current_password])
end
```

#### Rotas
Gerenciadas pelo Devise sob `/users`:
- `GET /users/sign_up`, `POST /users`
- `GET /users/edit`, `PUT/PATCH /users`
- `DELETE /users`

#### Exemplo de cadastro
```bash
curl -i -X POST -H "Content-Type: application/x-www-form-urlencoded" \
  -d "user[name]=Jane Doe&user[email]=jane@example.com&user[password]=secret123&user[password_confirmation]=secret123" \
  http://localhost:3000/users
```