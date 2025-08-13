Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  # Defina a rota do dashboard explicitamente
  get "dashboard", to: "dashboard#index", as: :dashboard

  # Rotas para categorias (dentro do bloco draw)
  resources :categories, except: [ :show ] do
    collection do
      patch :sort # Para reordenação (opcional)
    end
  end

  # Rotas root condicionais
  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "home#index", as: :unauthenticated_root
  end

  get "home/index"
  get "up" => "rails/health#show", as: :rails_health_check
end
