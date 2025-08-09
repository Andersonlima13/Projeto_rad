class Transaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

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

  # Validação customizada para garantir que a categoria pertence ao usuário
  validate :category_belongs_to_user

  scope :incomes, -> { where(transaction_type: "income") }
  scope :expenses, -> { where(transaction_type: "expense") }

  private

  def category_belongs_to_user
    if category && category.user != user
      errors.add(:category, "must belong to the same user")
    end
  end
end
