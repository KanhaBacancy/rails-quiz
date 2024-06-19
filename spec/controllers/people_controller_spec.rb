require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  subject { response }
  describe 'GET index' do
    before { get :index }

    it { is_expected.to have_http_status(:ok) }
  end

  describe 'GET #new' do
    before do
      get :new
    end

    it 'responds successfully' do
      expect(response).to be_successful
    end

    it 'returns a 200 response' do
      expect(response).to have_http_status '200'
    end

    it 'creates a new Person instance' do
      expect(controller.instance_variable_get(:@person)).to be_a_new(Person)
    end

    it 'loads all of the companies into @companies' do
      expect(controller.instance_variable_get(:@companies)).to eq(Company.all)
    end
  end

  describe 'POST create' do
    it 'Creates a record' do
      expect{ post :create, params: { person: { name: 'foo', phone_number: '123', email: 'foo' } } }.to change{ Person.count }.by(1)
    end

    it 'has status found' do
      expect(post :create, params: { person: { name: 'foo', phone_number: '123', email: 'foo' } }).to have_http_status(:found)
    end
  end
end
