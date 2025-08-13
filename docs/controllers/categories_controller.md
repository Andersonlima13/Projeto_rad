### CategoriesController

- Inherits: `ApplicationController`
- Filters: `before_action :set_category` for `edit, update, destroy`
- Auth: required

#### Actions
- `index`
  - Assigns `@categories = current_user.categories.order(:name)`
  - Assigns `@category = current_user.categories.new` (typically for inline form usage)
- `create`
  - Builds from `current_user.categories.new(category_params)`
  - On success: responds to Turbo Stream and HTML redirect to `categories_path`
  - On failure: Turbo Stream renders `form_update`; HTML renders `index`
- `update`
  - Updates a user-owned category via `@category.update(category_params)`
  - Redirects to `categories_path` on success; renders `edit` on failure
- `destroy`
  - Destroys a user-owned category
  - Responds with Turbo Stream removal or HTML redirect

#### Strong parameters
```ruby
def category_params
  params.require(:category).permit(:name, :position)
end
```
Note: `position` is permitted but not present in `db/schema.rb`.

#### Private helpers
- `set_category` → `@category = current_user.categories.find(params[:id])`

#### Usage examples
Create (HTML form snippet):
```erb
<%= form_with model: @category, url: categories_path do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <%= f.submit "Create" %>
<% end %>
```

Create (Turbo): ensure Turbo Stream templates exist (e.g., `create.turbo_stream.erb`) to handle stream responses.