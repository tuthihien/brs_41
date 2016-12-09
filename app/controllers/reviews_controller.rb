class ReviewsController < ApplicationController
  before_action :midleware_login, except: :show
  before_action :midleware_admin, only: :index
  before_action :review_load, except: :show

  def index
    @reviews = Review.paginate page: params[:page], per_page: Settings.per_page
  end

  def update
    @book = @review.book
    if @review.update_attributes params_update
      flash[:success] =  t "update_success"
      redirect_to @book
    else
      flash[:success] =  t "update_error"
      redirect_to :back
    end
  end

  def edit
  end

  def create
    @review = Review.new review_params
    if @review.save
      flash[:success] = t "success_create"
      book = Book.find_by_id @review.book_id
      redirect_to book
    else
      flash[:info] = t "error_create"
      render :new
    end
  end

  def show
    @review = review_load
    @comments = @review.comments
  end

  def new
    @review = Review.new
    @book_id = params :book_id
  end

  def destroy
    @book = Book.find_by_id @review.book_id
    @review.destroy
    flash[:success] = t "delete_success"
    redirect_to @book
    unless @book
      flash[:success] = t "error_destroy"
    end
  end

  private
  def review_params
    params.require(:review).permit :title, :content, :book_id, :user_id
  end

  def params_update
    params.require(:review).permit :title, :content
  end

  def review_load
    @review = Review.find_by_id params[:id]
    unless @review
      flash[:success] = t "error_back"
      redirect_to root_url
    end
  end
end
