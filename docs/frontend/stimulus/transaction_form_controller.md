### transaction_form_controller

Arquivo: `app/javascript/controllers/transaction_form_controller.js`

- Targets: `categorySelect`
- Ação: `updateCategories(event)` busca opções de categorias para o tipo de transação selecionado e espera uma resposta Turbo Stream para atualizar o select de categorias.

```javascript
export default class extends Controller {
  static targets = ["categorySelect"]

  updateCategories(event) {
    const transactionType = event.target.value
    fetch(`/categories/options?transaction_type=${transactionType}`, {
      headers: { Accept: "text/vnd.turbo-stream.html" }
    })
      .then(response => response.text())
      .then(html => Turbo.renderStreamMessage(html))
  }
}
```

Exemplo de uso:
```html
<div data-controller="transaction-form">
  <select name="transaction[transaction_type]"
          data-action="change->transaction-form#updateCategories">
    <option value="income">Income</option>
    <option value="expense">Expense</option>
  </select>

  <select name="transaction[category_id]" data-transaction-form-target="categorySelect">
    <!-- opções serão atualizadas via Turbo Stream -->
  </select>
</div>
```

Observações:
- O controller chama `GET /categories/options?transaction_type=...` e espera um Turbo Stream que atualize o target `categorySelect`. Esse endpoint e o template Turbo Stream correspondente não estão presentes em `config/routes.rb` nem em `CategoriesController`. Adicione a rota e a ação para dar suporte a esse comportamento, por exemplo:
```ruby
# config/routes.rb
resources :categories do
  collection { get :options }
end

# app/controllers/categories_controller.rb
def options
  @categories = current_user.categories.where(transaction_type: params[:transaction_type])
  respond_to { |format| format.turbo_stream }
end
```
