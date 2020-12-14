class BorrowedBooksController < ApplicationController
  def index
    @borrowed_books = BorrowedBook.all.includes(:book)
  end

  def create
    @borrowed_book = BorrowedBook.new(borrowed_book_params)
    @book = @borrowed_book.book
    if @book.reduce_available_quantity
      render_error(@borrowed_book) unless @borrowed_book.save
    else
      render_error(@book)
    end
  end

  def return_book
    @borrowed_book = BorrowedBook.where(borrowed_book_params).first
    @borrowed_book.update(book_returned: true)
    @book = @borrowed_book.book
    user = @borrowed_book.user
    if @book.increase_available_quantity
      if @borrowed_book.save
        user.subtract_book_fee(@book)
        render :create
      else
        render_error(@borrowed_book)
      end
    else
      render_error(@book)
    end
  end

  def status
    @on_loan = BorrowedBook.where(book_returned: false).count
    @total_loaned = BorrowedBook.count
    @total_earnings = BorrowedBook.calculate_earnings
  end

  private

  def borrowed_book_params
    params.require(:borrowed_book).permit(:book_id, :user_id)
  end

  def render_error(*args)
    render json: { errors: args.map do |arg|
      { "#{arg.class}": arg.errors.full_messages }
    end },
           status: :unprocessable_entity
  end
end
