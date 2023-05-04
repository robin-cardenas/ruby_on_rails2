class PayrollsController < ApplicationController
  before_action :set_payroll, only: %i[ show update destroy ]
  # before_action :authenticate_user!

  rescue_from ArgumentError do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @payrolls = Payroll.where(company_id: current_user.company_id)
  end

  def show
  end

  def create
    @payroll = Payroll.new(payroll_params)

    @payroll.settle_payroll
    
    if @payroll.save
      render :show, status: :created
    else
      render json: {errors: @payroll.errors}, status: :unprocessable_entity
    end
  end

  def search
    @payrolls = Payroll.where(company_id: params[:company_id])

    render :index, satatus: :ok
  end

  def update
    if @payroll.update(payroll_params)
      render :show, status: :ok, location: @payroll
    else
      render json: @payroll.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @payroll.destroy
  end

  private
    
    def set_payroll
      @payroll = Payroll.find(params[:id])
    end

    def payroll_params
      params.require(:payroll).permit(:employee_id, :company_id, :period_id, :other_income, :non_salaries, :other_deductions)
    end

    def authorized_user!
      if current_user.company_id == @payroll.company_id
        
      end
    end
end
