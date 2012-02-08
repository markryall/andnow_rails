require 'net/http'

class HomeController < ApplicationController
  def index
    redirect_to '/home/login' unless session[:email]
  end

  def logout
    session[:email] = nil
    redirect_to '/home/login'
  end

  def verify
    bid_resp = {}
    if params['assertion'] != nil
      http = Net::HTTP.new 'browserid.org', 443
      http.use_ssl = true
      response = http.post '/verify',
        "audience=#{request.host_with_port}&assertion=#{params['assertion']}",
        { 'Content-Type' => 'application/x-www-form-urlencoded' }
      begin
        bid_resp = JSON.parse response.body
        session[:email] = bid_resp['email'] if bid_resp['status'] == 'okay'
      rescue JSON::ParserError
        logger.info 'BrowserId returning bad JSON?'
      end
    end
    render json: bid_resp
  end
end