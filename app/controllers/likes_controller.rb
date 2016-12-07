class LikesController < ApplicationController
  before_action :midleware_login, :other_activities, only: [:destroy, :create]

  def create
    activity = Activity.find_by_id params[:id]
    active_like = Like.new target: activity, user_id: current_user.id
    if active_like.save
      @user = User.find_by_id params[:user_id]
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "error_return"
      redirect_to :back
    end
  end

  def destroy
    like = Like.scope_target_id params[:id]
    if like.present?
      active_like = like.find_by_user_id current_user.id
      active_like.destroy
      @user = User.find_by_id params[:user_id]
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "error_return"
      redirect_to :back
    end
  end
end
