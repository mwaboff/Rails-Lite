require 'json'
require 'webrick'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @cookie = {}
    @cookie_name = '_rails_lite_app'
    req.cookies.each do |cookie|
      if cookie.name == @cookie_name
        p cookie.value
        @cookie = JSON.parse(cookie.value)
      end
    end
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.cookies << WEBrick::Cookie.new(@cookie_name, @cookie.to_json)
  end
end
