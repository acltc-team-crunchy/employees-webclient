class EmployeesController < ApplicationController

  def show
    @employee = Unirest.get("http://localhost:3000/api/v1/employees/#{params[:id]}.json").body
  end

  def index
    @employees = Unirest.get("http://localhost:3000/api/v1/employees.json").body
  end
end
