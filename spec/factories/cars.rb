FactoryBot.define do
  factory :car do
    title              {'ランドクルーザーは大きくて、かっこいい'}
    text               {Faker::Lorem.sentence}
    maker_id           {rand(1..44)}
    car_name           {'ランドクルーザー'}
    body_type_id       {rand(1..9)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end