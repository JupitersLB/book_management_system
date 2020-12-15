# Book Management System

A quick demonstration of a book management system API.

You can create a new user, and view the user at a later date to check the balance
and the books they have borrowed.

A user can see a list of books or an individual book where it displays the fee and how
many are left. The user can also check the earnings of the book in a given timeframe.

A user can also view all the borrowed books that are currently on loan and the history.
They can borrow a new book or return a book which has already been borrowed. Finally,
they can check how many have been loaned, currently on loan, and the total earnings.

## Requirements

Ruby 2.6.6

### Start up

bundle install

rails db:create db:migrate db:seed

rails s

bundle exec rspec (check tests)
