require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  subject { response }
  describe 'GET index' do
    before { get :index }

    it { is_expected.to have_http_status(:ok) }
  end

  describe 'GET new' do
    before { get :new }

    it { is_expected.to have_http_status(:ok) }
  end

  describe 'POST create' do
    it 'Creates a record' do
      expect{ post :create, params: { person: { name: 'foo', phone_number: '123', email: 'foo@bar.com' } } }.to change{ Person.count }.by(1)
    end

    it 'does not create a record when email is invalid' do
      post :create, params: { person: { name: 'foo', phone_number: '123', email: 'invalid_email' } }
      expect(assigns(:person).errors[:email]).to include("is invalid")
    end
  end
end
