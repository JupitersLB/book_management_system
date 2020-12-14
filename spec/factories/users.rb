FactoryBot.define do
  factory :user do
    account_number { 'JLB' + 7.times.map { rand(0..9) }.join }
    balance { 5000 }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
