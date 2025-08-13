### ApplicationMailer

Base class for mailers.

```ruby
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
```

- Set a real default sender address in production, e.g., `no-reply@yourdomain.com`.
- Create mailers inheriting from `ApplicationMailer` and views under `app/views/...`.

Example:
```ruby
class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail to: user.email, subject: "Welcome"
  end
end
```