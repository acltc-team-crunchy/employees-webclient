class EmployeesController < ApplicationController

  def show
    @employee = Employee.find(params[:id])    
  end

  def index
    @employees = Employee.all
  end

  def new
  end

  def create
    @employee = Employee.create(first_name: params[:first_name], last_name: params[:last_name])
    redirect_to "/employees/#{@employee.id}"
  end

  def edit
    @employee = Unirest.get("#{ENV['DOMAIN']}/employees/#{params[:id]}.json").body
  end

  def update 
    @employee = Unirest.patch("#{ENV['DOMAIN']}/employees/#{params[:id]}.json", headers: {"Accept" => "application/json"}, parameters: {first_name: params[:first_name], last_name: params[:last_name], email: params[:email], ssn: params[:ssn], birthdate: params[:birthdate]}).body
    redirect_to "/employees/#{@employee['id']}"
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy

    
    redirect_to "/employees"
  end

end
