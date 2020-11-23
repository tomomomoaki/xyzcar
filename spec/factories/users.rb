FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 5) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    favorite_car          { 'ランドクルーザー' }
    introduction          { Faker::Lorem.sentence }
  end
end
