puts 'Cleaning database'
BorrowedBook.destroy_all
Book.destroy_all
User.destroy_all
puts 'Cleaned'

puts 'Creating users'
params = {}
params[:email] = 'liam@library.com'
params[:password] = 'password'
params[:account_number] = 'JLB12345'
params[:balance] = 15000
new_user = User.new(params)
new_user.save
puts "Created user #{new_user.id}"

params = {}
params[:email] = 'sat@library.com'
params[:password] = 'password'
params[:account_number] = 'JLB67890'
params[:balance] = 15000
new_user = User.new(params)
new_user.save
puts "Created user #{new_user.id}"

puts 'Users created'

puts 'Creating Books'

10.times do
  params = {}
  params[:title] = Faker::Book.title
  params[:available_quantity] = rand(5..9)
  params[:fee] = 350
  new_book = Book.create(params)
  puts "Created book #{new_book.id}"
end

puts 'Books created'

puts 'Creating borrowed books'

user = User.first

params = {}
params[:book] = Book.first
params[:user] = user
new_borrowed_book = BorrowedBook.new(params)
new_borrowed_book.save
book = new_borrowed_book.book
book.reduce_available_quantity
puts "Created borrowed book #{new_borrowed_book.id}"

params = {}
params[:book] = Book.second
params[:user] = user
new_borrowed_book = BorrowedBook.new(params)
new_borrowed_book.save
book = new_borrowed_book.book
book.reduce_available_quantity
puts "Created borrowed book #{new_borrowed_book.id}"

params = {}
params[:book] = Book.third
params[:user] = user
new_borrowed_book = BorrowedBook.new(params)
new_borrowed_book.save
new_borrowed_book.update(book_returned: true)
user.subtract_book_fee(new_borrowed_book.book)
puts "Created borrowed book #{new_borrowed_book.id}"

params = {}
params[:book] = Book.third
params[:user] = User.second
new_borrowed_book = BorrowedBook.new(params)
new_borrowed_book.save
book = new_borrowed_book.book
book.reduce_available_quantity
puts "Created borrowed book #{new_borrowed_book.id}"

puts 'Borrowed books created'
