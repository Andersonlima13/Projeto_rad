### HomeController

- Herda: `ApplicationController`
- Ações: `index`
- Auth: obrigatória por herança. Se desejar uma página inicial pública para usuários não autenticados, adicione:
```ruby
class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
end
```