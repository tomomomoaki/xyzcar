FactoryBot.define do
  factory :save_cars_tag do
    title              {'ランドクルーザーは大きくて、かっこいい'}
    images             {["1.png","2.png"]}
    text               {Faker::Lorem.sentence}
    maker_id           {rand(1..44)}
    car_name           {'ランドクルーザー'}
    body_type_id       {rand(1..9)}
    name               {"#かっこいい,#TOYOTA"}

  end
end