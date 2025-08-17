class AddAccountIdToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_reference :transactions, :account, null: false, foreign_key: true
  end
end
