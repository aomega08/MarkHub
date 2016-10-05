class SocialEntity < ApplicationRecord
  belongs_to :team

  validates :network, :network_id, :display_name, :team, presence: true
  validates :network_id, uniqueness: { scope: [:network, :team, :kind] }
end
