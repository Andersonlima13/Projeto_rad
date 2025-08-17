Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  # Rotas para accounts (com transactions aninhadas)
  resources :accounts, except: [ :show ] do
    collection do
      patch :sort # Para reordenação (opcional)
    end

    # Rotas para transactions aninhadas em accounts
    resources :transactions
  end

  # Rotas para categorias
  resources :categories, except: [ :show ] do
    collection do
      patch :sort # Para reordenação (opcional)
    end
  end

  # Rotas root condicionais
  authenticated :user do
    root to: "accounts#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "home#index", as: :unauthenticated_root
  end

  # Rotas auxiliares
  get "home/index"
  get "up" => "rails/health#show", as: :rails_health_check
end
