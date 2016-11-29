class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include RelationshipsHelper

  def midleware_login
    unless login?
      flash[:succsess] = t "login_continue"
      redirect_to login_path
    end
  end
end
