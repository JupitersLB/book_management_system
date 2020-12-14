FactoryBot.define do
  sequence(:title) { |n| "Star Wars: Episode #{n}" }
  factory :book do
    title
    available_quantity { rand(5..9) }
    fee { 300 }
  end
end
