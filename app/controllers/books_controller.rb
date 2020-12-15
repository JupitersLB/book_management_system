class BooksController < ApplicationController
  before_action :find_book, only: %i[show search]

  def index
    @books = Book.all
  end

  def show
    not_found unless @book
  end

  def search
    return not_found unless @book

    @start = params[:from_date].to_datetime
    @end = params[:to_date].to_datetime.end_of_day
    @earnings = @book.borrowed_books
                     .where(updated_at: @start..@end)
                     .calculate_earnings
  end

  private

  def not_found
    render json: { errors: "Can't find Book" },
           status: 404
  end

  def find_book
    @book = Book.where(id: params[:id]).first
  end
end
