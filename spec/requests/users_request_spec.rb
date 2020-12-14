require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }

  describe 'GET /users/:id' do
    before { get "/v1/users/#{user_id}" }

    context 'When the record exists' do
      it "JSON body response contains expected user attributes" do
        json_response = JSON.parse(response.body)
        expect(json_response['user'].keys)
          .to match_array(%w[id account_number balance books outstanding_payments])
      end

      it 'returns status code 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns record not found' do
        expect(response.status).to eq(404)
      end

      it 'returns error message' do
        expect(JSON.parse(response.body)).to eq({ 'errors' => "Can't find User" })
      end
    end
  end

  describe 'POST /users' do
    let(:valid_attributes) { { user: { balance: 1000 } } }

    context 'when the request is valid' do
      before { post '/v1/users', params: valid_attributes }

      it 'creates a user' do
        json_response = JSON.parse(response.body)
        expect(json_response['user']['balance']).to eq(1000)
      end

      it 'returns status code 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/v1/users', params: { user: { email: 'test@gmail.com' } } }

      it 'returns status code 422' do
        expect(response.status).to eq(422)
      end

      it 'returns a validation failure message' do
        json_response = JSON.parse(response.body)
        expect(json_response)
          .to eq({ 'errors' => ["Balance is not a number"] })
      end
    end
  end
end
