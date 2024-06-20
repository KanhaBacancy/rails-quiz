module Api
  module V1
    class CompaniesController < ApplicationController
      def create
        companies = Company.create!(company_params[:companies])
        render json: { companies: companies }, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    
      private
    
      def company_params
        params.permit(companies: [:name])
      end
    end
  end  
end  