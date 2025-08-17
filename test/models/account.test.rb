# test/models/account_test.rb
require "test_helper"

class AccountTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test "should be valid" do
    account = Account.new(name: "Conta Corrente", limit: 1000, user: @user)
    assert account.valid?
  end

  test "name should be present" do
    account = Account.new(name: "", limit: 1000, user: @user)
    assert_not account.valid?
  end

  test "limit should be present" do
    account = Account.new(name: "Conta Corrente", user: @user)
    assert_not account.valid?
  end

  test "limit should be greater than or equal to 0" do
    account = Account.new(name: "Conta Corrente", limit: -1, user: @user)
    assert_not account.valid?
  end
end
