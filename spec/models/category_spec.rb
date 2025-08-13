require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { create(:user) }

  it "é válido com atributos válidos" do
    category = build(:category, user: user)
    expect(category).to be_valid
  end

  it "é inválido sem nome" do
    category = build(:category, name: nil, user: user)
    expect(category).not_to be_valid
  end

  it "não permite nomes duplicados (case insensitive) para o mesmo usuário" do
    create(:category, name: "Comida", user: user)
    category = build(:category, name: "comida", user: user)
    expect(category).not_to be_valid
  end

  it "permite nomes duplicados para usuários diferentes" do
    user2 = create(:user)
    create(:category, name: "Comida", user: user)
    category = build(:category, name: "Comida", user: user2)
    expect(category).to be_valid
  end
end
