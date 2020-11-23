FactoryBot.define do
  factory :car do
    title              { Faker::Name.initials(number: 10) }
    images             { ['1.png', '2.png'] }
    text               { Faker::Lorem.sentence }
    maker_id           { rand(1..44) }
    car_name           { 'ランドクルーザー' }
    body_type_id       { rand(1..9) }
    association :user
  end
end
