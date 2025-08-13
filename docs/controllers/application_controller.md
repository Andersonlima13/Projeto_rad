### ApplicationController

Aplica autenticação e define os redirecionamentos pós-autenticação.

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

- Todos os controllers herdam esse comportamento por padrão.
- Para tornar ações públicas, use `skip_before_action :authenticate_user!` quando necessário.
