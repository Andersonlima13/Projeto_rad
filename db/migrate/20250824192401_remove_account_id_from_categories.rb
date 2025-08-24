class RemoveAccountIdFromCategories < ActiveRecord::Migration[8.0]
  def change
    remove_reference :categories, :account, null: true, foreign_key: true
  end
end
