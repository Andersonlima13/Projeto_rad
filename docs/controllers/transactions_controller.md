### TransactionsController

- Inherits: `ApplicationController`
- Filters: `before_action :authenticate_user!`; `before_action :set_transaction` for `show, edit, update, destroy`
- Auth: required
- Routing: Not currently exposed in `config/routes.rb`. Add `resources :transactions` to enable.

#### Actions
- `index` → paginated list: `current_user.transactions.order(date: :desc).page(params[:page])`
- `new` → initializes `@transaction`
- `create` → builds from `current_user.transactions.new(transaction_params)`
- `edit` → edits `@transaction`
- `update` → updates and redirects on success; re-renders on failure
- `destroy` → deletes and redirects

#### Strong parameters
```ruby
def transaction_params
  params.require(:transaction).permit(
    :amount, :description, :date, :transaction_type, :category_id
  )
end
```

#### Constraints and validations
See [Transaction model](../models/transaction.md) for validation rules and scope methods.

#### Example usage (after adding routes)
Create via form:
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