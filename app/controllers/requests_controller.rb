class RequestsController < ApplicationController
  def index
    @requests = Request.by_order.paginate(page: params[:page],
      per_page: Settings.PerPage)
  end

  def create
    status = params[:request][:status]
    if status.nil?
      request = Request.new request_params
      if request.save
        flash[:success] = t "success_create"
        redirect_to root_url
      else
        flash[:info] = t "error_create"
        render :new
      end
    else
      category_id = params[:request][:cate_name]
      if category_id.empty?
        request = request_load
        category = compare_catetegory request.cate_name
        approve_request request, category
      else
        category = Category.find_by_id category_id
        request = Request.find_by_id params[:request][:id]
        approve_request request, category
        unless category.nil? && request.nil?
        flash[:success] = t("error_back")
        redirect_to root_url
        end
      end
    end
  end

  def destroy
    if @request.destroy
      flash[:success] = t "delete_success"
    else
      flash[:danger] = t "error"
    end
    redirect_to :back
  end

  private
  def request_params
    params.require(:request).permit(:cate_name, :title, :publish_date, :author,
      :num_of_page, :image).merge! user_id: current_user.id
  end

  def request_load
    @request = Request.find_by_id params[:id]
    unless @request.nil?
      flash[:success] = t("error_back")
      redirect_to root_url
    end
  end

  def approve_request request, category
    book = create_book
    if book.save
      flash[:success] = t "success_approve"
      redirect_to :back
    else
      flash[:success] = t "error_approve"
      redirect_to :back
    end
  end

  def create_book
    @book = Book.new category_id: category.id, title: request.title,
      publish_date: request.publish_date, author: request.author,
      num_of_page: request.num_of_page, rating: Settings.zero
  end

  def compare_catetegory category_name
    category = Category.request_category
    unless category
      category = Category.create name: category_name
    end
  end
end
