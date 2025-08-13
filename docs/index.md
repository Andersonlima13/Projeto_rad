# Project Documentation

This documentation covers the public endpoints, controllers, models, and frontend components in this application. It includes examples and usage instructions.

- See HTTP endpoints: [docs/endpoints.md](./endpoints.md)
- Controllers:
  - [DashboardController](./controllers/dashboard_controller.md)
  - [HomeController](./controllers/home_controller.md)
  - [CategoriesController](./controllers/categories_controller.md)
  - [TransactionsController](./controllers/transactions_controller.md)
  - [Users::SessionsController](./controllers/users_sessions_controller.md)
  - [Users::RegistrationsController](./controllers/users_registrations_controller.md)
- Models:
  - [User](./models/user.md)
  - [Category](./models/category.md)
  - [Transaction](./models/transaction.md)
- Frontend:
  - [Stimulus overview](./frontend/stimulus/index.md)
  - Controllers:
    - [hello_controller](./frontend/stimulus/hello_controller.md)
    - [reset_form_controller](./frontend/stimulus/reset_form_controller.md)
    - [transaction_form_controller](./frontend/stimulus/transaction_form_controller.md)
- Authentication: [docs/authentication.md](./authentication.md)

Notes:
- Unless explicitly stated, all controller actions inherit `before_action :authenticate_user!` from `ApplicationController` and therefore require an authenticated session.