### ApplicationJob

Classe base para jobs em segundo plano usando ActiveJob.

```ruby
class ApplicationJob < ActiveJob::Base
  # retry_on ActiveRecord::Deadlocked
  # discard_on ActiveJob::DeserializationError
end
```

- Use adaptadores como Sidekiq em produção (configure em `config/application.rb` ou nos arquivos de ambiente).
- Crie jobs herdando de `ApplicationJob` e coloque na fila com `perform_later`.

Exemplo:
```ruby
class RecalculateTotalsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    # processamento
  end
end

# Enfileirar
RecalculateTotalsJob.perform_later(current_user.id)
```