require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { described_class.new(name: "Anderson", email: "teste@exemplo.com", password: "123456") }

  # ----------------
  # Associações
  # ----------------
  it { should have_many(:categories).dependent(:destroy) }
  it { should have_many(:accounts).dependent(:destroy) }
  it { should have_many(:transactions).through(:accounts) }

  # ----------------
  # Validações
  # ----------------
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(2) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_value("valid@email.com").for(:email) }
  it { should_not allow_value("invalid_email").for(:email) }

  it { should validate_length_of(:password).is_at_least(6).on(:create) }

  # ----------------
  # Casos práticos
  # ----------------
  it "é válido com nome, email e senha" do
    expect(user).to be_valid
  end

  it "é inválido sem nome" do
    user.name = nil
    expect(user).not_to be_valid
  end

  it "é inválido com email duplicado" do
    described_class.create!(name: "Outro", email: "teste@exemplo.com", password: "123456")
    expect(user).not_to be_valid
  end

  # ----------------
  # Dependência em cascata
  # ----------------
  it "remove contas e categorias associadas ao ser destruído" do
  user.save!
  account = user.accounts.create!(name: "Conta Teste", limit: 1000)
  category = user.categories.create!(name: "Categoria Teste")

  expect { user.destroy }.to change { Account.count }.by(-1)
                         .and change { Category.count }.by(-1)
  end
end
