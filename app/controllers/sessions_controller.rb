class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      user_login user
      flash[:success] = t "welcome"
      redirect_to root_url
    else
      flash[:danger] = t "valid"
      render :new
    end
  end

  def destroy
    if login?
      log_out
      flash[:success] = t "logout"
      redirect_to root_url
    end
  end
end
