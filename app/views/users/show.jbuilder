json.user do
  json.id @user.id
  json.account_number @user.account_number
  json.balance @user.balance
  json.outstanding_payments @user.outstanding_payments
  json.books do
    json.array! @user.books do |book|
      json.partial! 'books/book.jbuilder', book: book
    end
  end
end
