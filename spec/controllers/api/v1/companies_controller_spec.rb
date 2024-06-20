require 'rails_helper'

RSpec.describe Api::V1::CompaniesController, type: :controller do
  describe 'POST #create' do
    let(:valid_attributes) do
      { companies: [{ name: 'DigitalOcean' }, { name: 'GitHub' }] }
    end

    context 'when the request includes valid authentication headers' do
      before do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(ENV['API_USERNAME'], ENV['API_PASSWORD'])
        post :create, params: valid_attributes
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request does not include valid authentication headers' do
      before { post :create, params: valid_attributes }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end