### Model Transaction

- Tabela: `transactions`
- Associações:
  - `belongs_to :category`
  - `belongs_to :user`
- Atributos (do schema):
  - `id: integer`
  - `amount: decimal`
  - `description: text`
  - `date: date`
  - `transaction_type: string` (um de `income`, `expense`)
  - `category_id: integer`
  - `user_id: integer`
  - `created_at: datetime`
  - `updated_at: datetime`
- Validações:
  - `amount` presença, numérico maior que 0
  - `description` presença, tamanho máximo 100
  - `date` presença, inclusão no intervalo `2000-01-01..(Date.current + 1.day)`
  - `transaction_type` inclusão em `["income", "expense"]`
  - Customizada: `category` deve pertencer ao mesmo `user`
- Escopos:
  - `incomes` → `where(transaction_type: "income")`
  - `expenses` → `where(transaction_type: "expense")`

Exemplo (Rails console):
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