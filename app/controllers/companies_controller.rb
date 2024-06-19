class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update destroy]

  def index
    @companies = Company.all
  end

  def show;  end

  def new
    @company = Company.new
  end

  def edit;  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to @company, notice: 'Company was successfully created.'
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@company, partial: 'companies/form', locals: { company: @company }) }
        format.html { render :new }
      end
    end
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("edit_company_#{@company.id}", partial: 'companies/form', locals: { company: @company }) }
        format.html { render :edit }
      end
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_url, notice: 'Company was successfully destroyed.'
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name)
  end
end
