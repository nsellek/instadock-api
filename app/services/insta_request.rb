class InstaRequest
  class << self
    BASE_URL = 'https://api.instagram.com/'

    def get(endpoint, params={})
      RestClient.get(BASE_URL + endpoint,
                     {params: params}
                     )
    end

    def post(endpoint, params={}, type='application/x-www-form-urlencoded')
      RestClient.post(BASE_URL + endpoint,
                      params,
                      {content_type: type}
                      )
    end

    def del(endpoint, params={})
      RestClient.delete(BASE_URL + endpoint,
                        params
                        )
    end
  end
end