class UpdateTransactionsForAccounts < ActiveRecord::Migration[6.1]
  def change
    # Adiciona a referência para account
    add_reference :transactions, :account, foreign_key: true

    # Remove a referência direta para user (opcional, pode manter se quiser)
    remove_reference :transactions, :user, foreign_key: true

    # Atualiza as transações existentes para apontar para uma conta padrão
    reversible do |dir|
      dir.up do
        # Cria uma conta padrão para usuários que não têm contas
        User.find_each do |user|
          if user.accounts.empty?
            user.accounts.create!(name: "Conta Principal", limit: 0)
          end
        end

        # Atribui todas as transações à primeira conta do usuário
        Transaction.find_each do |transaction|
          account = transaction.user.accounts.first
          transaction.update!(account_id: account.id)
        end
      end
    end
  end
end
