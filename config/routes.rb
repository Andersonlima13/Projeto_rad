Rails.application.routes.draw do
  get "dashboard/index"
  get "home/index"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"  # Adicione esta linha
  }

   authenticated :user do
    root "dashboard#index", as: :dashboard
  end
  unauthenticated do
    root "home#index"
  end



  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"
end
