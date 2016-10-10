class FacebookAccount
  attr_reader :entity

  def initialize(entity)
    @entity = entity
  end

  def social_icon
    '<i class="fa fa-facebook"></i>'.html_safe
  end

  def display_name
    entity.display_name
  end

  def profile_image
    "http://graph.facebook.com/#{entity.network_id}/picture?type=square"
  end

  def client
  end
end
