require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :name }
end
