class SocialEntity < ApplicationRecord
  belongs_to :team

  validates :network, :network_id, :team, presence: true
end
