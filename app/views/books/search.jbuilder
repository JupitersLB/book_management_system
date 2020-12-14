json.book_profits do
  json.book_id @book.id
  json.title @book.title
  json.fee @book.fee
  json.search do
    json.start_date @start.to_s(:long)
    json.end_date @end.to_s(:long)
    json.earnings @earnings.nil? ? 0 : @earnings
  end
end
