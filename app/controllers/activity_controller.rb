class ActivityController < ApplicationController
  before_filter :require_login

  def show
    @sessions = Session.where(
      "user_id = ? AND description = ?",
      session[:user_id],
      params[:activity]
    ).order "start_time DESC"
  end
end