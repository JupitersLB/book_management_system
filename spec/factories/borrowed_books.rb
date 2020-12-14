FactoryBot.define do
  factory :borrowed_book do
    book_returned { false }
    user { nil }
    book { nil }
  end
end
