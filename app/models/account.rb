# app/models/account.rb
class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions, dependent: :destroy

  validates :name, presence: true
  validates :limit, numericality: { greater_than_or_equal_to: 0 }

  def current_balance
    total_income - total_expenses + limit
  end

  def transactions_count
    transactions.count
  end

  def total_income
    transactions.where(transaction_type: "income").sum(:amount)
  end

  def total_expenses
    transactions.where(transaction_type: "expense").sum(:amount)
  end
end
