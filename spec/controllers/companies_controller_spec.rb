require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let(:valid_attributes) { { name: "Test Company" } }
  let(:invalid_attributes) { { name: "" } }
  let(:company) { Company.create!(valid_attributes) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: company.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: company.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Company" do
        expect {
          post :create, params: { company: valid_attributes }
        }.to change(Company, :count).by(1)
      end

      it "redirects to the created company" do
        post :create, params: { company: valid_attributes }
        expect(response).to redirect_to(Company.last)
      end
    end

    context "with invalid params" do
      it "renders the new template" do
        post :create, params: { company: invalid_attributes }
        expect(response).to render_template("new")
      end

      it "renders turbo stream for invalid params" do
        post :create, params: { company: invalid_attributes }, format: :turbo_stream
        expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: "Updated Company" } }

      it "updates the requested company" do
        put :update, params: { id: company.to_param, company: new_attributes }
        company.reload
        expect(company.name).to eq("Updated Company")
      end

      it "redirects to the company" do
        put :update, params: { id: company.to_param, company: new_attributes }
        expect(response).to redirect_to(company)
      end
    end

    context "with invalid params" do
      it "renders the edit template" do
        put :update, params: { id: company.to_param, company: invalid_attributes }
        expect(response).to render_template("edit")
      end

      it "renders turbo stream for invalid params" do
        put :update, params: { id: company.to_param, company: invalid_attributes }, format: :turbo_stream
        expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested company" do
      company = Company.create! valid_attributes
      expect {
        delete :destroy, params: { id: company.to_param }
      }.to change(Company, :count).by(-1)
    end

    it "redirects to the companies list" do
      delete :destroy, params: { id: company.to_param }
      expect(response).to redirect_to(companies_url)
    end
  end
end
