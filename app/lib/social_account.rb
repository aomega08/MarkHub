class SocialAccount
  attr_reader :entity

  def initialize(entity)
    @entity = entity
  end

  def display_name
    entity.display_name
  end

  def path
    'javascript:void(0)'
  end

  def social_icon
    '<i class="fa fa-question-circle"></i>'.html_safe
  end

  def profile_image
    ''
  end
end
