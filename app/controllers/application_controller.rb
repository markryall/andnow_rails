class ApplicationController < ActionController::Base
  protect_from_forgery
private
  def require_login
    unless logged_in?
      session[:url] = request.url
      redirect_to root_url
    end
    Time.zone = current_user.timezone if current_user and current_user.timezone
  end

  def logged_in?
    !!current_user
  end

  def current_user
    return nil unless session[:user_id] or params[:api_token]
    @current_user ||= User.find session[:user_id] if session[:user_id]
    token = Token.find_by_key params[:api_token] if params[:api_token]
    @current_user ||= token.user if token
    @current_user
  end
end
