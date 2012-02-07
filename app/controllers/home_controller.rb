require 'net/http'

class HomeController < ApplicationController
  def login
    ans = 'invalid'
    if (params['assertion'] != nil)
      assertion = params['assertion']
      audience = request.host_with_port
      http = Net::HTTP.new('browserid.org', 443)
      http.use_ssl = true
      headers = {
       'Content-Type' => 'application/x-www-form-urlencoded',
      }
      data = "audience="+audience+"&assertion="+assertion
      resp = http.post("/verify",data,headers)
      begin
        bid_resp = JSON.parse(resp.body)
        if (bid_resp['status'] == "okay")
          session[:email] = bid_resp['email']
          ans = "logged in as #{bid_resp['email']}"
        end
      rescue JSON::ParserError
        logger.info "BrowserId returning bad JSON?"
      end
    end
    render :text => ans
  end
end
