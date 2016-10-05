class User < ApplicationRecord
  has_secure_password

  has_many :team_users
  has_many :teams, through: :team_users

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def self.authenticate(email, password)
    user = find_by(email: email)
    user && user.authenticate(password)
  end
end
