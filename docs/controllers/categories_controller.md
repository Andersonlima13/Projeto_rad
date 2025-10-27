### CategoriesController

- Herda: `ApplicationController`
- Filtros: `before_action :set_category` para `edit, update, destroy`
- Auth: obrigatória

#### Ações
- `index`
  - Atribui `@categories = current_user.categories.order(:name)`
  - Atribui `@category = current_user.categories.new` (comum para uso em formulário inline)
- `create`
  - Cria a partir de `current_user.categories.new(category_params)`
  - Sucesso: responde com Turbo Stream e redireciona em HTML para `categories_path`
  - Falha: Turbo Stream renderiza `form_update`; HTML renderiza `index`
- `update`
  - Atualiza uma categoria do usuário via `@category.update(category_params)`
  - Redireciona para `categories_path` em sucesso; renderiza `edit` em falha
- `destroy`
  - Remove uma categoria do usuário
  - Responde com remoção via Turbo Stream ou redirecionamento HTML

#### Parâmetros fortes
```ruby
def category_params
  params.require(:category).permit(:name, :position)
end
```
Observação: `position` está permitido, mas não consta em `db/schema.rb`.

#### Métodos privados
- `set_category` → `@category = current_user.categories.find(params[:id])`

#### Exemplos de uso
Criar (trecho de formulário HTML):
```erb
<%= form_with model: @category, url: categories_path do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <%= f.submit "Create" %>
<% end %>
```

Criar (Turbo): garanta que existam templates Turbo Stream (por exemplo, `create.turbo_stream.erb`) para lidar com as respostas via stream.