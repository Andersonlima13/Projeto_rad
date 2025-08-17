class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, except: [ :index ] # Carrega a conta para ações específicas
  before_action :set_transaction, only: [ :show, :edit, :update, :destroy ]

  def index
    # Mostra transações de todas as contas do usuário
    @transactions = current_user.transactions.includes(:account).order(date: :desc).page(params[:page])
  end

  def new
    @transaction = @account.transactions.new
  end

  def create
    @transaction = @account.transactions.new(transaction_params)

    if @transaction.save
      redirect_to account_transactions_path(@account), notice: "Transação criada com sucesso."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to account_transactions_path(@account), notice: "Transação atualizada com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @transaction.destroy
    redirect_to account_transactions_path(@account), notice: "Transação removida com sucesso."
  end

  private

  def set_account
    # Para ações específicas (new, create, etc.), pega a conta dos params ou usa a padrão
    @account = if params[:account_id].present?
                 current_user.accounts.find(params[:account_id])
    else
                 @transaction&.account || current_user.accounts.first
    end
  end

  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :date, :transaction_type, :category_id)
  end
end
