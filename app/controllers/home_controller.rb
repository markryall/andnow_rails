require 'net/http'

class HomeController < ApplicationController
  def index
    redirect_to :login unless session[:email]
  end

  def logout
    session[:email] = nil
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
          user = User.create email: email unless user
          session[:email] = email
          session[:user_id] = user.id
        end
      rescue JSON::ParserError
        logger.info 'BrowserId returning bad JSON?'
      end
    end
    render json: bid_resp
  end
end