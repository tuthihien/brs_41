class BooksController < ApplicationController
  before_action :load_book, except: [:create, :new]
  before_action :all_category, only: [:new, :edit]

  def index
    @books = Book.recent.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @reviews = @book.reviews
    @rating = @book.rating
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.new book_params
    if book.save
      flash[:success] = t "success_book_create"
      redirect_to books_path
    else
      flash[:info] = t "error_create"
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "update_book_success"
      redirect_to books_path
    else
      flash[:error] = t "update_book_error"
      render :back
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "delete_book_success"
      redirect_to books_path
    else
      flash[:success] = t "delete_book_error"
      render :back
    end
  end

  private
  def book_params
    params.require(:book).permit :title, :publish_date, :author, :num_of_page,
      :category_id, :image
  end

  def load_book
    @book = Book.find_by_id params[:id]
    unless @book
      flash[:success] = t "error_return_home"
      redirect_to root_url
    end
  end

  def load_category
    @categories = Category.all
  end
end
