### ApplicationJob

Base class for background jobs using ActiveJob.

```ruby
class ApplicationJob < ActiveJob::Base
  # retry_on ActiveRecord::Deadlocked
  # discard_on ActiveJob::DeserializationError
end
```

- Use adapters like Sidekiq in production (configure in `config/application.rb` or environment files).
- Create jobs inheriting from `ApplicationJob` and enqueue with `perform_later`.

Example:
```ruby
class RecalculateTotalsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    # do work
  end
end

# Enqueue
RecalculateTotalsJob.perform_later(current_user.id)
```