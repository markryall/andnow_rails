class ApplicationController < ActionController::Base
  protect_from_forgery
private
  def require_login
    unless logged_in?
      flash[:error] = "You are not logged in"
      redirect_to root_url
    end
  end

  def logged_in?
    !!session[:user_id]
  end
end
