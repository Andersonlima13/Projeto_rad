### TransactionsController

- Herda: `ApplicationController`
- Filtros: `before_action :authenticate_user!`; `before_action :set_transaction` para `show, edit, update, destroy`
- Auth: obrigatória
- Rotas: não está exposto em `config/routes.rb`. Adicione `resources :transactions` para habilitar.

#### Ações
- `index` → lista paginada: `current_user.transactions.order(date: :desc).page(params[:page])`
- `new` → inicializa `@transaction`
- `create` → cria a partir de `current_user.transactions.new(transaction_params)`
- `edit` → edita `@transaction`
- `update` → atualiza e redireciona em sucesso; renderiza novamente em falha
- `destroy` → exclui e redireciona

#### Parâmetros fortes
```ruby
def transaction_params
  params.require(:transaction).permit(
    :amount, :description, :date, :transaction_type, :category_id
  )
end
```

#### Restrições e validações
Veja o [model Transaction](../models/transaction.md) para regras de validação e escopos.

#### Exemplo de uso (após adicionar as rotas)
Criar via formulário:
```erb
<%= form_with model: @transaction, url: transactions_path do |f| %>
  <%= f.number_field :amount, step: "0.01" %>
  <%= f.text_field :description %>
  <%= f.date_field :date %>
  <%= f.select :transaction_type, options_for_select([["Income","income"],["Expense","expense"]]) %>
  <%= f.collection_select :category_id, current_user.categories, :id, :name %>
  <%= f.submit "Save" %>
<% end %>
```