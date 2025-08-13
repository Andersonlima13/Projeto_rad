### Transaction model

- Table: `transactions`
- Associations:
  - `belongs_to :category`
  - `belongs_to :user`
- Attributes (from schema):
  - `id: integer`
  - `amount: decimal`
  - `description: text`
  - `date: date`
  - `transaction_type: string` (one of `income`, `expense`)
  - `category_id: integer`
  - `user_id: integer`
  - `created_at: datetime`
  - `updated_at: datetime`
- Validations:
  - `amount` presence, numericality greater than 0
  - `description` presence, length max 100
  - `date` presence, inclusion in `2000-01-01..(Date.current + 1.day)`
  - `transaction_type` inclusion in `["income", "expense"]`
  - Custom: `category` must belong to the same `user`
- Scopes:
  - `incomes` → `where(transaction_type: "income")`
  - `expenses` → `where(transaction_type: "expense")`

Example (Rails console):
```ruby
user = User.first
category = user.categories.first
Transaction.create!(
  user: user,
  category: category,
  amount: 49.99,
  description: "Dinner",
  date: Date.today,
  transaction_type: "expense"
)
```