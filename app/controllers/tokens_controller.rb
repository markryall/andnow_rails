class TokensController < ApplicationController
  before_filter :require_login

  def create
    token = Token.new params[:token]
    token.user = current_user
    token.save
    redirect_to user_url
  end

  def destroy
    Token.find(params[:id]).destroy
    redirect_to user_url
  end
end