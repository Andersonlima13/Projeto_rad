### transaction_form_controller

File: `app/javascript/controllers/transaction_form_controller.js`

- Targets: `categorySelect`
- Action: `updateCategories(event)` fetches category options for a selected transaction type and expects a Turbo Stream response to update the categories select.

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

Usage example:
```html
<div data-controller="transaction-form">
  <select name="transaction[transaction_type]"
          data-action="change->transaction-form#updateCategories">
    <option value="income">Income</option>
    <option value="expense">Expense</option>
  </select>

  <select name="transaction[category_id]" data-transaction-form-target="categorySelect">
    <!-- options will be updated via Turbo Stream -->
  </select>
</div>
```

Notes:
- The controller calls `GET /categories/options?transaction_type=...` and expects a Turbo Stream that updates the `categorySelect` target. This endpoint and corresponding Turbo Stream template are not present in `config/routes.rb` or `CategoriesController`. Add a route and action to support this behavior, e.g.:
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
