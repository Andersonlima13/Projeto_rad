### Model User

- Tabela: `users`
- Auth: Devise (`:database_authenticatable, :registerable, :recoverable, :rememberable, :validatable`)
- Associações:
  - `has_many :categories, dependent: :destroy`
  - `has_many :transactions, through: :categories`
- Atributos (do schema):
  - `id: integer`
  - `email: string`
  - `encrypted_password: string`
  - `reset_password_token: string`
  - `reset_password_sent_at: datetime`
  - `remember_created_at: datetime`
  - `name: string`
  - `created_at: datetime`
  - `updated_at: datetime`
- Validações:
  - `name` presença, mínimo 2 caracteres
  - `email` presença, unicidade (case-insensitive), formato RFC válido
  - `password` mínimo 6 caracteres (allow_nil: true em updates)

Exemplo (Rails console):
```ruby
user = User.create!(name: "Sam", email: "sam@example.com", password: "secret123")
user.categories.create!(name: "Utilities")
```