json.borrowed_book do
  json.id @borrowed_book.id
  json.book_id @borrowed_book.book_id
  json.user_id @borrowed_book.user_id
  json.book_returned @borrowed_book.book_returned
end
