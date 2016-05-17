class EmployeesController < ApplicationController

  def show
    @employee = Employee.find(params[:id])    
  end

  def index
    employee_hashes = Unirest.get("#{ENV['DOMAIN']}/employees.json").body
    @employees = []
    employee_hashes.each do |hash|
      @employees << Employee.new(hash)
    end
  end

  def new
  end

  def create
    @employee = Unirest.post("#{ENV['DOMAIN']}/employees.json", headers: {"Accept" => "application/json"}, parameters: {first_name: params[:first_name], last_name: params[:last_name]}).body
    redirect_to "/employees/#{@employee['id']}"
  end

  def edit
    @employee = Unirest.get("#{ENV['DOMAIN']}/employees/#{params[:id]}.json").body
  end

  def update 
    @employee = Unirest.patch("#{ENV['DOMAIN']}/employees/#{params[:id]}.json", headers: {"Accept" => "application/json"}, parameters: {first_name: params[:first_name], last_name: params[:last_name], email: params[:email], ssn: params[:ssn], birthdate: params[:birthdate]}).body
    redirect_to "/employees/#{@employee['id']}"
  end

  def destroy
    Unirest.delete("#{ENV['DOMAIN']}/employees/#{params[:id]}")
    redirect_to "/employees"
  end

end
