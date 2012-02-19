require 'csv'

class SessionsController < ApplicationController
  before_filter :require_login

  def index
    @sessions = Session.where("user_id = ?", session[:user_id]).order "start_time DESC"

    respond_to do |format|
      format.html
      format.csv
      format.json { render json: @sessions }
    end
  end

  def show
    @session = Session.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @session }
    end
  end

  def new
    @session = Session.new
    @session.start_time = Time.now.to_i

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @session }
    end
  end

  def edit
    @session = Session.find(params[:id])
  end

  def import
    lines = params[:import][:csv].tempfile.readlines
    headers = CSV.parse(lines.shift).first
    while line = lines.shift
      Session.create_for current_user, CSV.parse(line, headers: headers).first.to_hash
    end
    redirect_to sessions_path
  end

  def create
    with_session do
      Session.where([
        'description = ? AND start_time = ? AND user_id = ?',
        @session.description,
        @session.start_time,
        @session.user.id
      ]).delete_all

      respond_to do |format|
        if @session.save
          format.html { redirect_to sessions_path, notice: 'Session was successfully created.' }
          format.json { render json: @session, status: :created, location: @session }
        else
          format.html { render action: "new" }
          format.json { render json: @session.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    @session = Session.find(params[:id])

    respond_to do |format|
      if @session.update_attributes(params[:session])
        format.html { redirect_to sessions_path, notice: 'Session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @session = Session.find(params[:id])
    @session.destroy

    respond_to do |format|
      format.html { redirect_to sessions_url }
      format.json { head :no_content }
    end
  end
private
  def with_session
    session_params = params[:session]
    return unless session_params
    session_params.delete :user_id
    session_params[:description].strip! if session_params[:description]
    @session = Session.new session_params
    @session.user = current_user
    yield
  end
end
