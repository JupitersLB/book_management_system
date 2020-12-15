json.borrowed_book do
  json.id @borrowed_book.id
  json.book_id @borrowed_book.book_id
  json.book_title @book.title
  json.book_available_quantity @book.available_quantity
  json.user_id @borrowed_book.user_id
  json.new_user_balance @user.balance
  json.book_returned @borrowed_book.book_returned
end
