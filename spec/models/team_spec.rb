require 'rails_helper'

describe Team do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:team)).to be_valid
  end

  it { is_expected.to have_many :team_users }
  it { is_expected.to have_many(:users).through(:team_users) }
  it { is_expected.to have_many :social_entities }

  it { is_expected.to validate_presence_of :name }
end
