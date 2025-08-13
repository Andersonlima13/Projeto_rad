## Endpoints HTTP

Todos os endpoints retornam HTML renderizado no servidor (com Turbo Streams em alguns casos). APIs JSON não são expostas, a menos que indicado.

- Por padrão, todos os controllers exigem autenticação devido a `before_action :authenticate_user!` em `ApplicationController`.

### Rotas raiz
- Root autenticado: `GET /` → `DashboardController#index`
- Root não autenticado: `GET /` → `HomeController#index`
  - Observação: `HomeController` atualmente herda a autenticação. Para permitir acesso público, adicione `skip_before_action :authenticate_user!` dentro de `HomeController`.

### Saúde
- `GET /up` → health check do Rails. Retorna 200 com JSON/HTML básico.

### Dashboard
- `GET /dashboard` → `DashboardController#index`
  - Auth: obrigatória
  - Resposta: página HTML

### Categorias
- Caminho base: `/categories`
- Ações implementadas:
  - `GET /categories` → `CategoriesController#index`
    - Exibe a lista de categorias e inicializa `@category` para o formulário novo
  - `POST /categories` → `CategoriesController#create`
    - Parâmetros (form ou x-www-form-urlencoded):
      - `category[name]` (String, obrigatório)
      - `category[position]` (Integer, opcional)
        - Observação: `position` está permitido nos strong params, mas não existe no schema do banco (db/schema.rb); considere remover ou adicionar a coluna.
    - Respostas:
      - HTML: redireciona para `/categories` em caso de sucesso; renderiza novamente em caso de erro
      - Turbo Stream: renderiza atualizações via stream
  - `PATCH /categories/:id` → `CategoriesController#update`
    - Parâmetros: mesmos do create
    - Resposta: redireciona para `/categories` em caso de sucesso; renderiza `edit` em caso de erro
  - `DELETE /categories/:id` → `CategoriesController#destroy`
    - Resposta: remoção via Turbo Stream ou redirecionamento HTML para `/categories`
- Declarado nas rotas mas não implementado no controller:
  - `GET /categories/new` → Não há ação correspondente
  - `GET /categories/:id/edit` → Não há ação correspondente (o before_action espera)
  - `PATCH /categories/sort` → A rota existe, mas não há ação `sort` definida

Exemplo: criar categoria
```bash
curl -i -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -b cookies.txt -c cookies.txt \
  -d "category[name]=Bills" \
  http://localhost:3000/categories
```

Exemplo: excluir categoria
```bash
curl -i -X DELETE \
  -b cookies.txt -c cookies.txt \
  http://localhost:3000/categories/123
```

### Devise (Usuários)
O Devise fornece rotas padrão sob `/users`, usando controllers customizados em `app/controllers/users`.

Rotas comuns incluem:
- Sessões: `GET /users/sign_in`, `POST /users/sign_in`, `DELETE /users/sign_out`
- Registros: `GET /users/sign_up`, `POST /users`, `GET /users/edit`, `PUT/PATCH /users`, `DELETE /users`

Observações de comportamento:
- Após o login, usuários são redirecionados para `dashboard_path`.
- Após o logout, usuários são redirecionados para a página de login.

### Transações
Um `TransactionsController` existe, mas não há rotas declaradas para ele em `config/routes.rb`. Para expor endpoints, adicione nas rotas:
```ruby
resources :transactions
```
Assim, as seguintes ações ficarão disponíveis: `index, new, create, edit, update, destroy`.

Exemplo (após adicionar as rotas):
```bash
curl -i -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -b cookies.txt -c cookies.txt \
  -d "transaction[amount]=19.99&transaction[description]=Coffee&transaction[date]=2025-08-01&transaction[transaction_type]=expense&transaction[category_id]=1" \
  http://localhost:3000/transactions
```