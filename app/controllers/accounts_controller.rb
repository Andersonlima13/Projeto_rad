# app/controllers/accounts_controller.rb
class AccountsController < ApplicationController
  before_action :set_account, only: [ :edit, :update, :destroy ]

  def index
    @accounts = current_user.accounts
    @recent_transactions = current_user.transactions.order(created_at: :desc).limit(5)
  end

def new
  @account = current_user.accounts.new

  # Se for uma requisição AJAX/Turbo, renderize sem layout
  if request.xhr? || request.format.turbo_stream?
    render layout: false
  else
    render layout: true # Layout padrão
  end
end





def create
  @account = current_user.accounts.new(account_params)

  respond_to do |format|
    if @account.save
      format.html { redirect_to accounts_path, notice: "Conta criada com sucesso." }
      format.turbo_stream
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end
end






 def edit
  @account = current_user.accounts.find(params[:id])
 end





def update
  @account = current_user.accounts.find(params[:id])

  if @account.update(account_params)
    redirect_to accounts_path, notice: "Conta atualizada com sucesso."
  else
    render :edit, status: :unprocessable_entity
  end
end



def recent_transactions
  @recent_transactions = current_user.transactions
                                    .order(created_at: :desc)
                                    .page(params[:page])
                                    .per(8) # 8 por página
end


def all_accounts
  @accounts = current_user.accounts.order(created_at: :desc)
  render :all_accounts
end




def destroy
  @account = current_user.accounts.find(params[:id])
  @account.destroy

  respond_to do |format|
    format.html do
      redirect_to accounts_path,
                  notice: "Conta removida com sucesso.",
                  status: :see_other
    end
    format.turbo_stream do
      render turbo_stream: [
        turbo_stream.remove(@account),
        turbo_stream.update("flash", partial: "shared/flash", locals: { notice: "Conta removida com sucesso." })
      ]
    end
  end
end

def show
  @account = current_user.accounts.find(params[:id])
end



 def current_balance
    limit - transactions.expenses.sum(:amount) + transactions.incomes.sum(:amount)
 end

  def available_limit
    limit - transactions.expenses.sum(:amount)
  end







  private

  def set_account
    @account = current_user.accounts.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :limit)
  end
end
