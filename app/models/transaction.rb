class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :date, presence: true
  validates :transaction_type, presence: true, inclusion: { in: %w[income expense] }

  scope :incomes, -> { where(transaction_type: "income") }
  scope :expenses, -> { where(transaction_type: "expense") }
end
