require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  subject { response }
  describe "GET #index" do
    let(:company) { create(:company) }
    let(:person) { create(:person, company: company) }

    it "assigns @people including associated companies" do
      get :index

      expect(assigns(:people)).to eq([person])  

      expect(assigns(:people).first.company).to eq(company)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe 'GET new' do
    before { get :new }

    it { is_expected.to have_http_status(:ok) }
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
