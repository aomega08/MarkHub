class TwitterAccount
  attr_reader :entity

  def initialize(entity)
    @entity = entity
  end

  def social_icon
    '<i class="fa fa-twitter"></i>'.html_safe
  end

  def display_name
    entity.display_name
  end

  def profile_image
    "https://twitter.com/#{entity.display_name}/profile_image?size=bigger"
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = entity.credentials[:access_token]
      config.access_token_secret = entity.credentials[:access_token_secret]
    end
  end
end
