module Twitter
  class Client
    attr_accessor :callback

    def credentials
      {
        consumer_key: consumer_key,
        consumer_secret: consumer_secret,
        token: access_token,
        token_secret: access_token_secret,
        callback: callback
      }
    end
  end
end
