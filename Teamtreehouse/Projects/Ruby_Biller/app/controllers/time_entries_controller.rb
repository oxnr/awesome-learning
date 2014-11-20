class TimeEntriesController < ApplicationController
  def create
    e = Employee.find(params[:employee_id])
    e.time_entries.create(params.require(:time_entry).permit(:time, :account_id))
    redirect_to employee_path(e)
  end
end
