class Team < ApplicationRecord
  has_many :team_users
  has_many :users, through: :team_users

  has_many :social_entities

  validates :name, presence: true
end
