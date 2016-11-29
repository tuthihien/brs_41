class UsersController < ApplicationController
  before_action :user_load, only: [:destroy, :show]

  def index
    @users = User.newest.paginate page: params[:page],
      per_page: Settings.page_paginate
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      user_login @user
      flash[:success] = t "success"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    if @user.destroy
      flash[:success] = t "delete"
    else
      flash[:danger] = t "error"
    end
    redirect_to :back
  end

  def update
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit :email, :fullname, :password,
      :password_confirmation
  end

  def user_load
    @user = User.find_by_id params[:id]
    unless @user
      flash[:danger] = t "error"
      redirect_to root_path
    end
  end
end
