require 'rails_helper'

RSpec.describe BorrowedBook, type: :model do
  it 'borrowed book has a valid factory' do
    expect(build(:borrowed_book)).to be_valid
  end

  subject do
    described_class.new(
      book: create(:book),
      user: create(:user)
    )
  end

  context 'valid' do
    it 'with valid attributes' do
      expect(subject).to be_valid
    end
  end

  context 'not valid' do
    it 'refuses to borrow same book to same user' do
      borrowed_book = create(:borrowed_book)
      second_book = described_class.new(
        book: borrowed_book.book,
        user: borrowed_book.user
      )
      expect(second_book).not_to be_valid
    end

    it 'user balance insufficient' do
      user_two = create(:user)
      user_two.update(balance: 1)
      subject.update(user: user_two)

      expect(subject).not_to be_valid
    end
  end
end
