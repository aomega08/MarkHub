module OAuth
  class TwitterController < ApplicationController
    def new
      redirect_to "https://api.twitter.com/oauth/authenticate?oauth_token=#{oauth_token}&force_login=1"
    end

    def create
      values = CGI.parse(access_token_from_verifier(params[:oauth_verifier]))

      team.social_entities.create({
        network: 'twitter', kind: 'user',
        display_name: values['screen_name'].first, network_id: values['user_id'].first,
        credentials: { oauth_token: values['oauth_token'], oauth_secret: values['oauth_secret'] }.to_json
      })

      redirect_to dashboard_path
    end

    private

    def client
      @_twitter_client ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['twitter_consumer_key']
        config.consumer_secret     = ENV['twitter_consumer_secret']
        config.callback            = oauth_twitter_callback_url
      end
    end

    def oauth_token
      response = CGI.parse(reverse_token)
      response['oauth_token'].first
    end

    def reverse_token
      url = "https://api.twitter.com/oauth/request_token"
      auth_header = Twitter::Headers.new(client, :post, url, {}).oauth_auth_header.to_s

      require 'http'
      HTTP.headers(authorization: auth_header).post(url).to_s
    end

    def access_token_from_verifier(verifier)
      url = "https://api.twitter.com/oauth/access_token"
      client.oauth_token = params[:oauth_token]
      auth_header = Twitter::Headers.new(client, :post, url, {}).oauth_auth_header.to_s

      require 'http'
      HTTP.headers(authorization: auth_header).post(url, params: { oauth_verifier: verifier }).to_s
    end
  end
end
