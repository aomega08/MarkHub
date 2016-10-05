class SocialEntity < ApplicationRecord
  belongs_to :team

  validates :network, :network_id, :display_name, :team, presence: true
end
