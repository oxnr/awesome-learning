class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def create
    e = Employee.create(params.require(:employee).permit(:name))
    redirect_to employee_path(e)
  end
end
