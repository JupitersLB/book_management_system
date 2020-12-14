class BorrowedBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_uniqueness_of :book, scope: :user
  validate :user_balance, on: :create

  def user_balance
    user = self.user
    book = self.book
    return if user.borrowed_books.empty? && book.fee < user.balance

    pending_balance = user.outstanding_payments
    return unless pending_balance + book.fee > user.balance

    errors.add(:balance, 'for User is insufficient')
  end

  def self.calculate_earnings
    deep_pluck(book: :fee)
      .map { |ele| ele[:book]['fee'] }
      .reduce(:+)
  end
end
