class CategoriesController < ApplicationController
  before_action :category, only: %i(destroy update edit)

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: t('category.successful_create')
    else
      render :new
    end
  end

  def index
    @categories = Category.all
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path,  notice: t('category.successful_update')
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: t('category.successful_destroy')
    else
      redirect_to categories_path, alert: t('category.error_destroy')
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def category
    @category = Category.find(params[:id])
  end
end
