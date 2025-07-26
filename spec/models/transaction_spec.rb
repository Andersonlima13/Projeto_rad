require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }

  it 'is valid with valid attributes' do
    transaction = build(:transaction, user: user, category: category)
    expect(transaction).to be_valid
  end

  it 'is not valid without an amount' do
    transaction = build(:transaction, amount: nil, user: user, category: category)
    expect(transaction).not_to be_valid
  end

  # Outros testes
end
