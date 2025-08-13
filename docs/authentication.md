### Authentication

This application uses Devise for user authentication and session management. All controllers inherit from `ApplicationController`, which enforces authentication by default:

```ruby
class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
```

- After sign in → users are redirected to the dashboard
- After sign out → users are redirected to the sign-in page

To make specific actions public, opt out explicitly:
```ruby
class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
end
```

Devise controllers customized:
- Sessions: sets flash messages and redirects to dashboard on success
- Registrations: permits `name`, `email`, `password`, and related fields on sign up and account update

Common routes (handled by Devise):
- Sessions: `/users/sign_in` (GET, POST), `/users/sign_out` (DELETE)
- Registrations: `/users/sign_up` (GET, POST), `/users` (PUT/PATCH/DELETE)