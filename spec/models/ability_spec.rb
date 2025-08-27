require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  let(:user) { User.create!(name: "Anderson", email: "teste@exemplo.com", password: "123456") }
  let(:other_user) { User.create!(name: "Outro", email: "outro@exemplo.com", password: "123456") }

  subject(:ability) { Ability.new(user) }

  it "permite gerenciar suas próprias contas" do
    account = user.accounts.create!(name: "Minha Conta", limit: 100)
    expect(ability).to be_able_to(:manage, account)
  end

  it "não permite gerenciar contas de outros usuários" do
    other_account = other_user.accounts.create!(name: "Conta Alheia", limit: 100)
    expect(ability).not_to be_able_to(:manage, other_account)
  end
end
