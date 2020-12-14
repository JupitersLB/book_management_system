class User < ApplicationRecord
  has_many :borrowed_books, -> { where(book_returned: false) }
  has_many :books, through: :borrowed_books
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :account_number, presence: true
  validates :balance, numericality: { greater_than: 0 }

  def subtract_book_fee(book)
    self.update(balance: self.balance - book.fee)
  end

  def outstanding_payments
    res = borrowed_books
          .deep_pluck(book: :fee)
          .map { |ele| ele[:book]['fee'] }
          .reduce(:+)
    res.nil? ? 0 : res
  end
end
