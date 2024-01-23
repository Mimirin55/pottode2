class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_create_params)
    if @category.save
      flash[:notice] = 'おめでとう！カテゴリを作成できました'
      redirect_to categories_path
    else
      flash.now[:danger] = 'カテゴリを作成できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = 'おめでとう！カテゴリを更新できました'
      redirect_to categories_path
    else
      flash.now[:danger] = 'カテゴリを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy!
    redirect_to categories_path, notice: 'カテゴリを削除しました'
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def category_create_params
    params.permit(:name)
  end
end
