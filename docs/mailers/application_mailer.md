### ApplicationMailer

Classe base para mailers.

```ruby
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
```

- Defina um remetente real em produção, por exemplo, `no-reply@seudominio.com`.
- Crie mailers herdando de `ApplicationMailer` e views em `app/views/...`.

Exemplo:
```ruby
class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail to: user.email, subject: "Welcome"
  end
end
```