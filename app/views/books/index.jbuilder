json.books do
  json.array! @books do |book|
    json.partial! "book.jbuilder", book: book
  end
end
