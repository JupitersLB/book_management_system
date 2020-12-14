require 'rails_helper'

RSpec.describe 'BorrowedBooks API', type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let!(:borrowed_books) { create_list(:borrowed_book, 5) }
  let(:borrowed_book) { create(:borrowed_book) }

  describe 'GET /borrowed_books' do
    context 'when all books on loan' do
      before { get '/v1/borrowed_books' }

      it 'returns books on loan' do
        expect(response.body).not_to be_empty
        expect(JSON.parse(response.body)['borrowed_books']['books_on_loan'].size)
          .to eq(5)
      end
    end

    context 'when books have been returned' do
      before do
        borrowed_books.first.update(book_returned: true)
        get '/v1/borrowed_books'
      end

      it 'returns books that have been returned' do
        expect(JSON.parse(response.body)['borrowed_books']['books_returned'].size)
          .to eq(1)
      end
    end
  end

  describe 'POST /borrowed_books' do
    let(:valid_attributes) do
      { borrowed_book: { book_id: book.id, user_id: user.id } }
    end

    context 'when the request is valid' do
      before { post '/v1/borrowed_books', params: valid_attributes }

      it 'creates a borrowed_book' do
        json_response = JSON.parse(response.body)
        expect(json_response['borrowed_book']['book_id']).to eq(book.id)
        expect(json_response['borrowed_book']['user_id']).to eq(user.id)
      end

      it 'returns status code 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'when the request is invalid' do
      before do
        user.update(balance: 1)
        post '/v1/borrowed_books',
             params: { borrowed_book: { book_id: book.id, user_id: user.id } }
      end

      it 'returns status code 422' do
        expect(response.status).to eq(422)
      end

      it 'returns a validation failure message' do
        json_response = JSON.parse(response.body)
        expect(json_response['errors'][0]['BorrowedBook'].join)
          .to eq('Balance for User is insufficient')
      end
    end
  end

  describe 'PATCH /borrowed_books/return_book' do
    let(:valid_attributes) do
      { borrowed_book: {
        book_id: borrowed_book.book_id, user_id: borrowed_book.user_id
      } }
    end

    context 'When the record exists' do
      before do
        patch '/v1/borrowed_books/return_book',
              params: valid_attributes
      end

      it 'updates the record' do
        json_response = JSON.parse(response.body)
        expect(json_response['borrowed_book']['book_returned']).to eq(true)
      end

      it 'returns status code 200' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET /borrowed_books/status' do
    before { get '/v1/borrowed_books/status' }

    it 'returns current state of affairs' do
      json_response = JSON.parse(response.body)
      expect(json_response['borrowed_books_status'].keys)
        .to match_array(%w[on_loan total_loaned total_earnings])
    end
  end
end
