### ApplicationController

Enforces authentication and defines post-auth redirections.

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

- All controllers inherit this behavior by default.
- Skip authentication on specific actions with `skip_before_action :authenticate_user!`.
