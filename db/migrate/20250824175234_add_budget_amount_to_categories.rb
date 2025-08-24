class AddBudgetAmountToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :budget_amount, :decimal
  end
end
