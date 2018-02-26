class InstaRequest
  class << self
    @@base_url = 'https://api.instagram.com/'

    def get(endpoint, params={})
      RestClient.get(@@base_url + endpoint,
                     {params: params}
                     )
    end

    def post(endpoint, params={}, type=:json)
      RestClient.post(@@base_url + endpoint,
                      params,
                      {content_type: type}
                      )
    end

    def del(endpoint, params={})
      RestClient.delete(@@base_url + endpoint,
                        params
                        )
    end
  end
end