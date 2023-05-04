class PayrollDetailsController < ApplicationController
  before_action :set_payroll_detail, only: %i[ show update destroy ]

  def index
    @payroll_details = PayrollDetail.all
  end

  def show
  end

  def create
    @payroll_detail = PayrollDetail.new(payroll_detail_params)

    if @payroll_detail.save
      render :show, status: :created, location: @payroll_detail
    else
      render json: @payroll_detail.errors, status: :unprocessable_entity
    end
  end

  def update
    if @payroll_detail.update(payroll_detail_params)
      render :show, status: :ok, location: @payroll_detail
    else
      render json: @payroll_detail.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @payroll_detail.destroy
  end

  private
    
    def set_payroll_detail
      @payroll_detail = PayrollDetail.find(params[:id])
    end

    def payroll_detail_params
      params.require(:payroll_detail).permit(:concept, :valor, :payroll_id)
    end
end
