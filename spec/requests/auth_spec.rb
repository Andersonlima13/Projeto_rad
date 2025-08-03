require 'rails_helper'

RSpec.describe "Autenticação", type: :request do
  it "permite cadastro de usuário" do
    get new_user_registration_path
    expect(response).to have_http_status(200)

    post user_registration_path, params: {
      user: {
        email: "usuario@exemplo.com",
        password: "123456",
        password_confirmation: "123456"
      }
    }
    expect(response).to redirect_to(root_path)
  end
end
