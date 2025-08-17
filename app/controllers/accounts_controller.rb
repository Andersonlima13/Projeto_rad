# app/controllers/accounts_controller.rb
class AccountsController < ApplicationController
  before_action :set_account, only: [ :edit, :update, :destroy ]

  def index
    @accounts = current_user.accounts
    @recent_transactions = current_user.transactions.order(created_at: :desc).limit(5)
  end

  def new
    @account = current_user.accounts.new
  end

  def create
    @account = current_user.accounts.new(account_params)
    if @account.save
      redirect_to accounts_path, notice: "Conta criada com sucesso."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @account.update(account_params)
      redirect_to accounts_path, notice: "Conta atualizada com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_path, notice: "Conta removida com sucesso."
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :limit)
  end
end
