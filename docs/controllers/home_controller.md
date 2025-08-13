### HomeController

- Inherits: `ApplicationController`
- Actions: `index`
- Auth: required by inheritance. If a public homepage is desired for unauthenticated users, add:
```ruby
class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
end
```