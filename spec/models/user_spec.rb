require 'rails_helper'

RSpec.describe User, type: :model do
  it 'user has a valid factory' do
    expect(build(:user)).to be_valid
  end

  subject do
    described_class.new(
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      account_number: 'JLB' + 7.times.map { rand(0..9) }.join,
      balance: 5000
    )
  end

  context 'valid' do
    it 'with valid attributes' do
      expect(subject).to be_valid
    end
  end

  context 'not valid' do
    it 'without an account number' do
      subject.account_number = nil
      expect(subject).not_to be_valid
    end

    it 'without an email' do
      subject.email = nil
      expect(subject).not_to be_valid
    end

    it 'without a password' do
      subject.password = nil
      expect(subject).not_to be_valid
    end

    it 'without a balance' do
      subject.balance = nil
      expect(subject).not_to be_valid
    end
  end
end
