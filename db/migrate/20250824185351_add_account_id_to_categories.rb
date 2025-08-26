# db/migrate/20250824185351_add_account_id_to_categories.rb
class AddAccountIdToCategories < ActiveRecord::Migration[8.0]
  def change
    add_reference :categories, :account, foreign_key: true
  end
end
