### Category model

- Table: `categories`
- Associations:
  - `belongs_to :user`
  - `has_many :transactions, dependent: :restrict_with_error`
- Attributes (from schema):
  - `id: integer`
  - `name: string`
  - `description: text`
  - `user_id: integer`
  - `created_at: datetime`
  - `updated_at: datetime`
- Validations:
  - `name` presence
  - `name` uniqueness scoped to `user_id` (case-insensitive)
  - `name` length maximum 30
  - Custom: `name` cannot be in `["all", "none", "undefined"]`

Example (Rails console):
```ruby
user = User.first
cat = user.categories.create!(name: "Groceries")
cat2 = user.categories.build(name: "none")
cat2.valid? # => false (reserved word)
cat2.errors.full_messages
```