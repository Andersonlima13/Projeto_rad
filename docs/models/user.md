### User model

- Table: `users`
- Auth: Devise (`:database_authenticatable, :registerable, :recoverable, :rememberable, :validatable`)
- Associations:
  - `has_many :categories, dependent: :destroy`
  - `has_many :transactions, through: :categories`
- Attributes (from schema):
  - `id: integer`
  - `email: string`
  - `encrypted_password: string`
  - `reset_password_token: string`
  - `reset_password_sent_at: datetime`
  - `remember_created_at: datetime`
  - `name: string`
  - `created_at: datetime`
  - `updated_at: datetime`
- Validations:
  - `name` presence, minimum length 2
  - `email` presence, uniqueness (case-insensitive), RFC-compliant format
  - `password` minimum length 6 (allow_nil: true on updates)

Example (Rails console):
```ruby
user = User.create!(name: "Sam", email: "sam@example.com", password: "secret123")
user.categories.create!(name: "Utilities")
```