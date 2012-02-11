class UsersController < ApplicationController
  before_filter :require_login

  def show
    @user = current_user
  end

  def update
    current_user.update_attributes params[:user]
    redirect_to user_url
  end
end