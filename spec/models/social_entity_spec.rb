require 'rails_helper'

describe SocialEntity do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:social_entity)).to be_valid
  end

  it { is_expected.to belong_to :team }

  it { is_expected.to validate_presence_of :network }
  it { is_expected.to validate_presence_of :network_id }
  it { is_expected.to validate_presence_of :display_name }
  it { is_expected.to validate_presence_of :team }
end
