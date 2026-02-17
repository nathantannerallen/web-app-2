class CompaniesController < ApplicationController

  def index
    @companies = Company.all
    # find all Company rows
    # render companies/index view
  end

  def show
    # find a Company
    @company = Company.find_by({ "id" => params["id"]})

    # render companies/show view with details about Company
  end

  def new
    # render view with new Company form
    
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to "/companies"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def edit
  #   # find a Company
  #   # render view with edit Company form
  # end

  # def update
  #   # find a Company
  #   # assign user-entered form data to Company's columns
  #   # save Company row
  #   # redirect user
  # end

  # def destroy
  #   # find a Company
  #   # destroy Company row
  #   # redirect user
  # end

  private

  def company_params
    params.permit(:name, :city, :state)
  end

end
