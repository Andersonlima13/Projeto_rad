class Category < ActiveRecord::Base
  belongs_to :user
  has_many :transactions, dependent: :restrict_with_error

  validates :name,
            presence: true,
            uniqueness: { scope: :user_id, case_sensitive: false },
            length: { maximum: 30 }

  # Validação para nomes não permitidos
  validate :name_not_reserved

  private

  def name_not_reserved
    reserved_words = %w[all none undefined]
    if reserved_words.include?(name.downcase)
      errors.add(:name, "#{name} is a reserved word")
    end
  end
end
