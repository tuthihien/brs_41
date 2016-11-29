class CategoriesController < ApplicationController
  def index
    @categories = Category.order_by_name.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new load_category
    if category.save
      flash[:success] =  t "success_category_create"
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes categories_params
      flash[:success] =  t "update_category_success"
      redirect_to categories_path
    else
      flash[:danger] = t "update_category_error"
      render :back
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "delete_category_success"
      redirect_to categories_path
    else
      flash[:danger] = @category.errors.full_messages
      redirect_to :back
    end
  end

  private
  def categories_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by_id params[:id]
    unless @category
      flash[:danger] = t "error_return_home"
      redirect_to root_url
    end
  end
end
