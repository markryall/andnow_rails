class ApplicationController < ActionController::Base
  protect_from_forgery
private
  def require_login
    unless logged_in?
      flash[:error] = "You are not logged in"
      redirect_to root_url
    end
    Time.zone = current_user.timezone if current_user and current_user.timezone
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    return nil unless session[:user_id]
    @current_user ||= User.find session[:user_id]
  end
end
