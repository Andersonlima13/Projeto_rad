require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { { name: "Transporte" } }
  let(:invalid_attributes) { { name: "" } }

  before { sign_in user }

  describe "GET #index" do
    it "retorna sucesso" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "com parâmetros válidos" do
      it "cria uma nova categoria" do
        expect {
          post :create, params: { category: valid_attributes }
        }.to change(Category, :count).by(1)
      end
    end

    context "com parâmetros inválidos" do
      it "não cria categoria" do
        expect {
          post :create, params: { category: invalid_attributes }
        }.not_to change(Category, :count)
      end
    end
  end
end
