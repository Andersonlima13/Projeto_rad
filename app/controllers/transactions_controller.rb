# app/controllers/transactions_controller.rb
class TransactionsController < ApplicationController
  before_action :set_account
  before_action :set_transaction, only: [ :show, :edit, :update, :destroy ]

  def index
    if @account
      @transactions = @account.transactions.includes(:category).order(date: :desc, created_at: :desc)
    else
      # Fallback para todas as transações do usuário
      @transactions = current_user.transactions.includes(:account, :category).order(date: :desc, created_at: :desc)
      flash.now[:alert] = "Conta não especificada. Mostrando todas as transações."
    end
  end

  def show
  end

  def new
    @transaction = @account.transactions.new(
      date: Date.current,
      transaction_type: params[:type] || "expense"
    )
  end

def create
  @transaction = @account.transactions.new(transaction_params)

  # Validação adicional para orçamento da categoria
  if @transaction.category&.budget_amount.present? && @transaction.category.budget_amount > 0
    current_spent = @transaction.category.spent_amount
    if current_spent + @transaction.amount > @transaction.category.budget_amount
      flash[:alert] = "Este gasto excede o orçamento definido para a categoria '#{@transaction.category.name}'"
      render :new and return
    end
  end

  respond_to do |format|
    if @transaction.save
      format.html { redirect_to account_path(@account), notice: "Transação criada com sucesso." }
      format.turbo_stream
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end
end

  def edit
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to account_transaction_path(@account, @transaction), notice: "Transação atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy
    redirect_to account_transactions_path(@account), notice: "Transação removida com sucesso."
  end

  private


def set_account
  if params[:account_id].present?
    begin
      @account = current_user.accounts.find(params[:account_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Conta não encontrada ou você não tem permissão para acessá-la."
      redirect_to accounts_path
      false
    end
  end
end




  def set_transaction
    if @account
      @transaction = @account.transactions.find(params[:id])
    else
      @transaction = current_user.transactions.find(params[:id])
    end
  end

  def transaction_params
    params.require(:transaction).permit(
      :amount, :description, :date, :transaction_type, :category_id
    )
  end
end
