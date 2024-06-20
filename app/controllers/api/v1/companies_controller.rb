module Api
  module V1
    class CompaniesController < ApplicationController
      def index
        @companies = Company.by_name(params[:name])
                
        if @companies.any?
          @companies = @companies.page(params[:page]).per(params[:per_page])
          render json: @companies
        else
          render json: { message: 'No Company found with the given email' }, status: :not_found
        end
      end
    end
  end
end