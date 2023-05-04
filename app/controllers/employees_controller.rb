class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show update destroy ]

  def index
    @employees = Employee.all
  end

  def show
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render :show, status: :created, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render :show, status: :ok, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
  end

  private
    
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:name, :document, :company_id)
    end
end
