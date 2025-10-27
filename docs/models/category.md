### Model Category

- Tabela: `categories`
- Associações:
  - `belongs_to :user`
  - `has_many :transactions, dependent: :restrict_with_error`
- Atributos (do schema):
  - `id: integer`
  - `name: string`
  - `description: text`
  - `user_id: integer`
  - `created_at: datetime`
  - `updated_at: datetime`
- Validações:
  - `name` presença
  - `name` unicidade escopada por `user_id` (case-insensitive)
  - `name` tamanho máximo 30
  - Customizada: `name` não pode ser uma das palavras `["all", "none", "undefined"]`

Exemplo (Rails console):
```ruby
user = User.first
cat = user.categories.create!(name: "Groceries")
cat2 = user.categories.build(name: "none")
cat2.valid? # => false (palavra reservada)
cat2.errors.full_messages
```