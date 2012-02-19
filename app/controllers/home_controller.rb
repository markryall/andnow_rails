require 'net/http'

class HomeController < ApplicationController
  def index
    if logged_in?
      if session[:url]
        redirect_to session[:url]
        session[:url] = nil
      end
    else
      redirect_to :login
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :login
  end

  def verify
    bid_resp = {}
    if params['assertion']
      http = Net::HTTP.new 'browserid.org', 443
      http.use_ssl = true
      response = http.post '/verify',
        "audience=#{request.host_with_port}&assertion=#{params['assertion']}",
        { 'Content-Type' => 'application/x-www-form-urlencoded' }
      begin
        bid_resp = JSON.parse response.body
        if bid_resp['status'] == 'okay'
          email = bid_resp['email']
          user = User.find_by_email email
          user = User.create email: email, token: Time.now.to_i unless user
          session[:user_id] = user.id
        end
      rescue JSON::ParserError
        logger.info 'BrowserId returning bad JSON?'
      end
    end
    render json: bid_resp
  end
end