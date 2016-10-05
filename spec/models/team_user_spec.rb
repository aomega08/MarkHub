require 'rails_helper'

describe TeamUser do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:team_user)).to be_valid
  end

  it { is_expected.to belong_to :team }
  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of :team }
  it { is_expected.to validate_presence_of :user }
end
