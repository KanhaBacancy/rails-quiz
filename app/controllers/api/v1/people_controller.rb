module Api
  module V1
    class PeopleController < ApplicationController
      def index
        @people = Person.by_email(params[:email])

        if @people.any?
          @people = @people.page(params[:page]).per(params[:per_page])
          render json: @people
        else
          render json: { message: 'No people found with the given email' }, status: :not_found
        end
      end
    end
  end
end