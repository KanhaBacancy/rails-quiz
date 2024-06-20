require 'rails_helper'

RSpec.describe Api::V1::PeopleController, type: :controller do
  describe 'GET #index' do
    let!(:person) { Person.create(name: "abc", email: 'test@example.com', phone_number: "1232312") }

    context 'when email exists' do
      before { get :index, params: { email: 'test@example.com', page: 1, per_page: 10 } }

      it 'returns the person with the given email' do
        expect(JSON.parse(response.body).first['email']).to eq('test@example.com')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when email does not exist' do
      before { get :index, params: { email: 'nonexistent@example.com', page: 1, per_page: 10 } }

      it 'returns a not found message' do
        expect(JSON.parse(response.body)['message']).to eq('No people found with the given email')
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end