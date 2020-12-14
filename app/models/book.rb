class Book < ApplicationRecord
  has_many :borrowed_books, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :fee, presence: true
  validates :available_quantity, numericality: { greater_than: 0 }

  def increase_available_quantity
    update(available_quantity: self.available_quantity += 1)
  end

  def reduce_available_quantity
    update(available_quantity: self.available_quantity -= 1)
  end
end
