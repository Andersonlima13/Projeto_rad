### Autenticação

Esta aplicação usa Devise para autenticação de usuários e gerenciamento de sessão. Todos os controllers herdam de `ApplicationController`, que impõe autenticação por padrão:

```ruby
class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
```

- Após o login → usuários são redirecionados para o dashboard
- Após o logout → usuários são redirecionados para a página de login

Para tornar ações específicas públicas, desative explicitamente:
```ruby
class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
end
```

Controllers do Devise customizados:
- Sessions: define mensagens flash e redireciona ao dashboard em sucesso
- Registrations: permite `name`, `email`, `password` e campos relacionados no cadastro e atualização de conta

Rotas comuns (gerenciadas pelo Devise):
- Sessions: `/users/sign_in` (GET, POST), `/users/sign_out` (DELETE)
- Registrations: `/users/sign_up` (GET, POST), `/users` (PUT/PATCH/DELETE)