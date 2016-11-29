class RelationshipsController < ApplicationController
  before_action :midleware_login, :load_user, only: [:create, :destroy]

  def create
    current_user.follow @user
    respond_to do |format|
      format.js
    end
  end

  def destroy
    current_user.unfollow @user
    respond_to do |format|
      format.js
    end
  end

  private
  def load_user
    @user = User.find_by id: params[:followed_id]
    unless @user
      flash[:danger]= t "not_user"
      redirect_to root_url
    end
  end
end
