class FacebookAccount < SocialAccount
  def social_icon
    '<i class="fa fa-facebook"></i>'.html_safe
  end

  def profile_image
    "http://graph.facebook.com/#{entity.network_id}/picture?type=square"
  end
end
