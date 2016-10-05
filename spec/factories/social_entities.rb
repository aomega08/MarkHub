FactoryGirl.define do
  factory :social_entity do
    team

    network 'facebook'
    kind 'page'
    network_id '1234567890'
    credentials '{"access_token":"ohmybase64=="}'
  end
end
