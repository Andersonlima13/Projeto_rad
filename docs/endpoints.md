## HTTP Endpoints

All endpoints are server-rendered HTML (with Turbo Streams in some cases). JSON APIs are not exposed unless noted.

- Authentication is required for all controllers by default due to `before_action :authenticate_user!` in `ApplicationController`.

### Root routes
- Authenticated root: `GET /` → `DashboardController#index`
- Unauthenticated root: `GET /` → `HomeController#index`
  - Note: `HomeController` currently inherits authentication. To allow public access, add `skip_before_action :authenticate_user!` inside `HomeController`.

### Health
- `GET /up` → Rails health check. Returns 200 with basic JSON/HTML.

### Dashboard
- `GET /dashboard` → `DashboardController#index`
  - Auth: required
  - Response: HTML page

### Categories
- Base path: `/categories`
- Implemented actions:
  - `GET /categories` → `CategoriesController#index`
    - Shows list of categories and initializes `@category` for the new form
  - `POST /categories` → `CategoriesController#create`
    - Params (form or x-www-form-urlencoded):
      - `category[name]` (String, required)
      - `category[position]` (Integer, optional)
        - Note: `position` is currently permitted but not present in the database schema as of db/schema.rb; consider removing or adding a column.
    - Responses:
      - HTML: redirects to `/categories` on success; re-renders on failure
      - Turbo Stream: renders stream updates
  - `PATCH /categories/:id` → `CategoriesController#update`
    - Params: same as create
    - Response: redirects to `/categories` on success; re-renders edit on failure
  - `DELETE /categories/:id` → `CategoriesController#destroy`
    - Response: Turbo Stream removal or HTML redirect to `/categories`
- Declared but not implemented in controller:
  - `GET /categories/new` → No corresponding action
  - `GET /categories/:id/edit` → No corresponding action (before_action expects it)
  - `PATCH /categories/sort` → Route exists but no `sort` action is defined

Example: create category
```bash
curl -i -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -b cookies.txt -c cookies.txt \
  -d "category[name]=Bills" \
  http://localhost:3000/categories
```

Example: delete category
```bash
curl -i -X DELETE \
  -b cookies.txt -c cookies.txt \
  http://localhost:3000/categories/123
```

### Devise (Users)
Devise provides standard routes under `/users`, using custom controllers in `app/controllers/users`.

Common routes include:
- Sessions: `GET /users/sign_in`, `POST /users/sign_in`, `DELETE /users/sign_out`
- Registrations: `GET /users/sign_up`, `POST /users`, `GET /users/edit`, `PUT/PATCH /users`, `DELETE /users`

Behavioral notes:
- After sign in, users are redirected to `dashboard_path`.
- After sign out, users are redirected to the sign-in page.

### Transactions
A `TransactionsController` exists, but there are no routes declared for it in `config/routes.rb`. To expose public endpoints, add to routes:
```ruby
resources :transactions
```
Then the following actions would be available: `index, new, create, edit, update, destroy`.

Example (after adding routes):
```bash
curl -i -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -b cookies.txt -c cookies.txt \
  -d "transaction[amount]=19.99&transaction[description]=Coffee&transaction[date]=2025-08-01&transaction[transaction_type]=expense&transaction[category_id]=1" \
  http://localhost:3000/transactions
```