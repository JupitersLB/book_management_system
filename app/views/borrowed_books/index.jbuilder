json.borrowed_books do
  json.books_on_loan do
    json.array! @borrowed_books.where(book_returned: false) do |bb|
      json.id bb.id
      json.user_id bb.user_id
      json.book do
        json.partial! "books/book.jbuilder", book: bb.book
      end
    end
  end
  json.books_returned do
    json.array! @borrowed_books.where(book_returned: true) do |bb|
      json.id bb.id
      json.user_id bb.user_id
      json.book do
        json.partial! "books/book.jbuilder", book: bb.book
      end
    end
  end
end
