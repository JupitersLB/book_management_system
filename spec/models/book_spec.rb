require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'book has a valid factory' do
    expect(build(:book)).to be_valid
  end

  subject do
    described_class.new(
      title: Faker::Book.title,
      available_quantity: rand(5..9),
      fee: 300
    )
  end

  context 'valid' do
    it 'with valid attributes' do
      expect(subject).to be_valid
    end
  end

  context 'not valid' do
    it 'without a title' do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it 'without a quantity' do
      subject.available_quantity = nil
      expect(subject).not_to be_valid
    end

    it 'without a fee' do
      subject.fee = nil
      expect(subject).not_to be_valid
    end
  end
end
