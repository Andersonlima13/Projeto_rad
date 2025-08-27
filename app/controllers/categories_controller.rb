class CategoriesController < ApplicationController
# Apenas necessário se você criar categorias vinculadas a uma conta
# before_action :set_account, only: [:create]

def create
  @category = current_user.categories.build(category_params)

  respond_to do |format|
    if @category.save
      format.turbo_stream
      format.html { redirect_back fallback_location: new_account_transaction_path(params[:account_id]), notice: "Categoria criada com sucesso." }
    else
      format.turbo_stream { render turbo_stream: turbo_stream.replace("new_category_form", partial: "categories/form", locals: { category: @category }) }
      format.html { redirect_back fallback_location: new_account_transaction_path(params[:account_id]), alert: @category.errors.full_messages.to_sentence }
    end
  end
end

def destroy
  @category = current_user.categories.find(params[:id])
  @category.destroy

  respond_to do |format|
    format.html { redirect_back fallback_location: request.referrer || accounts_path, notice: "Categoria removida com sucesso." }
    format.turbo_stream { render turbo_stream: turbo_stream.remove(@category) }
  end
end

  private

  # set_account removido, já que categoria não depende de account
  # def set_account
  #   @account = current_user.accounts.find(params[:account_id])
  # rescue ActiveRecord::RecordNotFound
  #   redirect_back fallback_location: accounts_path, alert: "Conta não encontrada."
  # end

  def category_params
    params.require(:category).permit(:name, :budget_amount)
  end
end
