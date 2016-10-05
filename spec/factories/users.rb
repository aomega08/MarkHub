FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    name { Faker::Name.name }

    teams { [FactoryGirl.build(:team)] }
  end
end
