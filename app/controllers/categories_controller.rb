class CategoriesController < ApplicationController
  before_action :set_category, only: [ :update, :destroy ]

  def index
    @categories = current_user.categories.order(:name)
    @category = current_user.categories.new
  end

def create
  @category = current_user.categories.new(category_params)

  begin
    if @category.save!
      redirect_back fallback_location: new_account_transaction_path(account_id: params[:account_id]),
                    notice: "Categoria criada com sucesso!"
    end
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.record.errors.full_messages.to_sentence
    redirect_back fallback_location: new_account_transaction_path(account_id: params[:account_id])
  end
end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "Categoria atualizada!"
    else
      render :edit
    end
  end
def destroy
  @category = current_user.categories.find(params[:id])
  if @category.transactions.any?
    redirect_back fallback_location: new_account_transaction_path(account_id: params[:account_id]),
                  alert: "Não é possível excluir uma categoria que possui transações associadas."
  else
    @category.destroy
    redirect_back fallback_location: new_account_transaction_path(account_id: params[:account_id]),
                  notice: "Categoria excluída com sucesso."
  end
end


  def budget_info
    category = current_user.categories.find(params[:id])
    render json: {
      category_name: category.name,
      budget_amount: category.budget_amount,
      spent_amount: category.spent_amount,
      remaining_budget: category.remaining_budget,
      remaining_budget_formatted: number_to_currency(category.remaining_budget)
    }
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :position, :budget_amount, :account_id)
  end
end
