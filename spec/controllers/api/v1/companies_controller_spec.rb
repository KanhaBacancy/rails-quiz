require 'rails_helper'

RSpec.describe Api::V1::CompaniesController, type: :controller do
  describe 'GET #index' do
    let!(:company) { Company.create(name: 'DigitalOcean') }

    context 'when name exists' do
      before { get :index, params: { name: 'Digital', page: 1, per_page: 10 } }

      it 'returns the company with the given name' do
        expect(JSON.parse(response.body).first['name']).to eq('DigitalOcean')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when name does not exist' do
      before { get :index, params: { name: 'Nonexistent', page: 1, per_page: 10 } }

      it 'returns a not found message' do
        expect(JSON.parse(response.body)['message']).to eq('No Company found with the given email')
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end