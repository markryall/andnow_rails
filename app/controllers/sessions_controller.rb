class SessionsController < ApplicationController
  before_filter :require_login, :except => [:create]

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.where("user_id = ?", session[:user_id]).order "start_time DESC"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sessions }
    end
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
    @session = Session.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @session }
    end
  end

  # GET /sessions/new
  # GET /sessions/new.json
  def new
    @session = Session.new
    @session.start_time = Time.now.to_i

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @session }
    end
  end

  # GET /sessions/1/edit
  def edit
    @session = Session.find(params[:id])
  end

  # POST /sessions
  # POST /sessions.json
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
          format.html { redirect_to @session, notice: 'Session was successfully created.' }
          format.json { render json: @session, status: :created, location: @session }
        else
          format.html { render action: "new" }
          format.json { render json: @session.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /sessions/1
  # PUT /sessions/1.json
  def update
    @session = Session.find(params[:id])

    respond_to do |format|
      if @session.update_attributes(params[:session])
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
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
    user = current_user
    if !user and session_params[:token]
      user = User.find_by_token session_params[:token]
      session_params.delete :token
    end
    session_params[:description].strip! if session_params[:description]
    @session = Session.new session_params
    @session.user = user
    yield
  end
end
