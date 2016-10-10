class SocialEntity < ApplicationRecord
  belongs_to :team

  validates :network, :network_id, :display_name, :team, presence: true
  validates :network_id, uniqueness: { scope: [:network, :team, :kind] }

  def twitter?
    network == 'twitter'
  end

  def credentials
    JSON.parse(self[:credentials]).with_indifferent_access if self[:credentials]
  end

  def present
    case network.to_sym
    when :twitter
      TwitterAccount.new(self)
    when :facebook
      FacebookAccount.new(self)
    else
      nil
    end
  end
end
