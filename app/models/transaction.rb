class Transaction < ActiveRecord::Base
  belongs_to :account
  belongs_to :category, optional: true  # Tornamos opcional para manter compatibilidade

  # Remova belongs_to :user pois agora o usuário será acessado via account
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

  # Validação customizada atualizada para verificar account e categoria
  validate :account_and_category_belong_to_same_user

  scope :incomes, -> { where(transaction_type: "income") }
  scope :expenses, -> { where(transaction_type: "expense") }

  # Método para acessar o usuário indiretamente via account
  delegate :user, to: :account, prefix: false

  private

  def account_and_category_belong_to_same_user
    # Verifica se a conta pertence ao usuário (implícito na relação)
    # Verifica se a categoria (se existir) pertence ao mesmo usuário da conta
    if category.present? && category.user != account.user
      errors.add(:category, "deve pertencer ao mesmo usuário da conta")
    end
  end
end
