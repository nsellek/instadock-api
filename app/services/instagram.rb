class Instagram

  def initialize
    @client_id = ENV['INSTA_CLIENT_ID']
    @client_secret = ENV['INSTA_CLIENT_SECRET']
  end

  def auth_token(auth_code)
    params = {
        'client_id': @client_id,
        'client_secret': @client_secret,
        'grant_type': 'authorization_code',
        'code': auth_code,
        'redirect_uri': ENV['REDIRECT_URL']
    }

    response = InstaRequest.post('oauth/access_token', params, 'application/x-www-form-urlencoded')
    JSON.parse(response.body)
  end

  def self_recent_media(access_token, max_id=nil)
    params = {
        'access_token': access_token,
        'max_id': max_id,
        'count': '15'
    }

    response = InstaRequest.get('v1/users/self/media/recent', params)
    JSON.parse(response.body)
  end
end