class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user

  validates :team, :user, presence: true
end
