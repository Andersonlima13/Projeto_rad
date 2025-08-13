class CategoriesController < ApplicationController
  before_action :set_category, only: [ :edit, :update, :destroy ]

  def index
    @categories = current_user.categories.order(:name)
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)
    respond_to do |format|
      if @category.save
        format.turbo_stream
        format.html { redirect_to categories_path, notice: "Categoria criada!" }
      else
        format.turbo_stream { render :form_update }
        format.html { render :index }
      end
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
    @category.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@category) }
      format.html { redirect_to categories_path, notice: "Categoria removida!" }
    end
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :position)
  end
end
