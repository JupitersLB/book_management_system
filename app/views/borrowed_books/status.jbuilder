json.borrowed_books_status do
  json.on_loan @on_loan
  json.total_loaned @total_loaned
  json.total_earnings @total_earnings
end
