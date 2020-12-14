class CreateBorrowedBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :borrowed_books do |t|
      t.boolean :book_returned, default: false
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
