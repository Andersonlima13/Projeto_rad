# Documentação do Projeto

Esta documentação cobre os endpoints públicos, controllers, models e componentes de frontend desta aplicação. Inclui exemplos e instruções de uso.

- Veja os endpoints HTTP: [docs/endpoints.md](./endpoints.md)
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
  - [Visão geral do Stimulus](./frontend/stimulus/index.md)
  - Controllers:
    - [hello_controller](./frontend/stimulus/hello_controller.md)
    - [reset_form_controller](./frontend/stimulus/reset_form_controller.md)
    - [transaction_form_controller](./frontend/stimulus/transaction_form_controller.md)
- Autenticação: [docs/authentication.md](./authentication.md)

Observações:
- Salvo indicação em contrário, todas as ações dos controllers herdam `before_action :authenticate_user!` de `ApplicationController` e portanto exigem uma sessão autenticada.