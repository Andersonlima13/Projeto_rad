class Category < ActiveRecord::Base
  belongs_to :user
  has_many :transactions, dependent: :restrict_with_error

  attribute :budget_amount, :decimal, default: 0.0

  validates :name,
            presence: true,
            uniqueness: { scope: :user_id, case_sensitive: false },
            length: { maximum: 30 }

  validates :budget_amount,
            numericality: { greater_than_or_equal_to: 0 },
            allow_nil: true

  validate :name_not_reserved
  validate :budget_does_not_exceed_available_balance, if: -> { budget_amount.present? && budget_amount > 0 }

  def spent_amount
    transactions.sum(:amount)
  end

  def remaining_budget
    return nil unless budget_amount.present?
    budget_amount - spent_amount
  end

  def budget_exceeded?
    return false unless budget_amount.present?
    spent_amount > budget_amount
  end

  private

  def name_not_reserved
    reserved_words = %w[all none undefined orçamento orcamento budget]
    if reserved_words.include?(name.downcase)
      errors.add(:name, "#{name} é uma palavra reservada")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def budget_does_not_exceed_available_balance
    total_balance = user.accounts.sum(&:current_balance)
    if budget_amount > total_balance
      errors.add(:budget_amount, "não pode exceder o saldo disponível total do usuário (#{ApplicationController.helpers.number_to_currency(total_balance)})")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end
end
