# app/models/transaction.rb
class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :category


  validates :amount,
            presence: true,
            numericality: { greater_than: 0 }

  validates :description,
            presence: true,
            length: { maximum: 100 }

  validates :date,
            presence: true,
            inclusion: {
              in: Date.new(2000, 1, 1)..Date.current + 1.day,
              message: "deve estar entre 01/01/2000 e amanhã"
            }

  validates :transaction_type,
            inclusion: { in: %w[income expense] }

  validate :account_and_category_belong_to_same_user
  validate :validate_account_balance, if: -> { transaction_type == "expense" && amount.present? }

  scope :incomes, -> { where(transaction_type: "income") }
  scope :expenses, -> { where(transaction_type: "expense") }

  delegate :user, to: :account, prefix: false

  private

  def account_and_category_belong_to_same_user
    if category.present? && category.user != account.user
      errors.add(:category, "deve pertencer ao mesmo usuário da conta")
    end
  end

  def validate_account_balance
    return unless account && amount > 0

    if amount > account.current_balance
      errors.add(:amount, "excede o saldo disponível da conta. Saldo disponível: #{number_to_currency(account.current_balance)}")
    end
  end
end


def account_and_category_belong_to_same_user
  if category.present? && category.user != account.user
    errors.add(:category, "deve pertencer ao mesmo usuário da conta")
  end
end
