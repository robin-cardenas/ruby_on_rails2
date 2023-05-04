class SalariesController < ApplicationController
  before_action :set_salary, only: %i[ show update destroy ]

  rescue_from ArgumentError do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @salaries = Salary.all
  end

  def show
  end

  def create
    @salary = Salary.new(salary_params)

    if @salary.save
      render :show, status: :created, location: @salary
    else
      render json: @salary.errors, status: :unprocessable_entity
    end
  end

  def update
    if @salary.update(salary_params)
      render :show, status: :ok, location: @salary
    else
      render json: @salary.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @salary.destroy
  end

  private
    
    def set_salary
      @salary = Salary.find(params[:id])
    end

    def salary_params
      params.require(:salary).permit(:base_salary, :initial_date, :final_date, :days_period, :employee_id)
    end
end
