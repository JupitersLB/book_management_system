require 'rails_helper'

RSpec.describe "Books API", type: :request do
  let!(:books) { create_list(:book, 3) }
  let(:book) { create(:book) }
  let(:borrowed_book) { create(:borrowed_book) }
  let(:book_id) { book.id }

  describe 'GET /books' do
    before { get '/v1/books' }

    it 'returns books' do
      expect(response.body).not_to be_empty
      expect(JSON.parse(response.body)['books'].size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /books/:id' do
    before { get "/v1/books/#{book_id}" }

    context 'When the record exists' do
      it "JSON body response contains expected book attributes" do
        json_response = JSON.parse(response.body)
        expect(json_response.keys)
          .to match_array(%w[id title available_quantity fee])
      end

      it 'returns status code 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'when the record does not exist' do
      let(:book_id) { 1000 }

      it 'returns record not found' do
        expect(response.status).to eq(404)
      end

      it 'returns error message' do
        expect(JSON.parse(response.body)).to eq({ 'errors' => "Can't find Book" })
      end
    end
  end

  describe 'GET /books/:id/search' do
    let(:valid_attributes) { { from_date: Date.today, to_date: Date.tomorrow } }
    before do
      borrowed_book.update(book: book)
      get "/v1/books/#{book_id}/search", params: valid_attributes
    end

    context 'when books exist' do
      it 'returns a book' do
        json_response = JSON.parse(response.body)
        expect(json_response['book_profits']['book_id']).to eq(book_id)
      end

      it 'returns a book in the search parameters' do
        json_response = JSON.parse(response.body)

        expect(
          book.borrowed_books.first.updated_at.between?(
            json_response['book_profits']['search']['start_date'],
            json_response['book_profits']['search']['end_date']
          )
        ).to eq(true)
      end
    end
  end
end
