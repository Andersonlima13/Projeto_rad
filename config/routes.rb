Rails.application.routes.draw do
  get "dashboard/index"
  get "home/index"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"  # Adicione esta linha
  }

  # Rota alternativa para logout via GET (apenas para desenvolvimento)
  devise_scope :user do
    get "/users/sign_out", to: "devise/sessions#destroy", as: :destroy_user_session_get
  end

  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"
end
