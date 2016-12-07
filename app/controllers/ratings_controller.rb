class RatingsController < ApplicationController
  before_action :midleware_login, only: :create

  def create
    @book = Book.find_by_id book.id
    @rating = @book.rating
    respond_to do |format|
      format.js
    end
  end

  private
  def create_activity
    activity = Activity.new user_id: current_user.id, action: Rating.name,
      target_id: params[:book_id], target_type: Book.name
    if activity.save
      rating_book
    else
      flash[:danger] = t "error_return"
      redirect_to root_url
    end
  end

  def rating_book
    book = Book.find_by_id params[:book_id]
    if book.present?
      rating_count = avg_rating book.id
      avg = (book.rating.to_f * rating_count + params[:rating].to_i)/(rating_count + 1)
      book.update_column :rating, avg
    else
      flash[:danger] = t "not_rating"
      redirect_to root_url
    end
  end
end
