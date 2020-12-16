FactoryBot.define do
  factory :save_cars_tag do
    genre_id           { rand(2..8) }
    title              { Faker::Name.initials(number: 10) }
    images             { ['1.png', '2.png'] }
    text               { Faker::Lorem.sentence }
    name               { '#かっこいい,#TOYOTA' }
    maker_id           { rand(1..44) }
    car_name           { 'ランドクルーザー' }
    grade              { '2.0i-S' }
    body_type_id       { rand(1..9) }
    new_or_old_id      { rand(1..7) }
    price              { rand(1..10000) }
    evaluation_id      { rand(1..6) }
  end
end
