FactoryBot.define do
  factory :borrowed_book do
    book { create(:book) }
    user { create(:user) }
    book_returned { false }
  end
end
