# app/models/category.rb
class Category < ApplicationRecord
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

# Decrementa o orçamento pelo valor passado
def decrement_budget!(amount)
  return unless budget_amount.present? && amount.present? && amount > 0

  if budget_amount - amount < 0
    raise StandardError, "🚨 Gasto maior que o orçamento previsto!!!"
  else
    update!(budget_amount: budget_amount - amount)
  end
end



  def spent_amount
    transactions.sum(:amount)
  end

  def remaining_budget
    return nil unless budget_amount.present?
    budget_amount - spent_amount
  end

  private

  def name_not_reserved
    reserved_words = %w[all none undefined orçamento orcamento budget]
    errors.add(:name, "#{name} é uma palavra reservada") if reserved_words.include?(name.downcase)
  end
end
