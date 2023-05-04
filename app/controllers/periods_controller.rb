class PeriodsController < ApplicationController
  before_action :set_period, only: %i[ show update destroy ]

  rescue_from ArgumentError do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @periods = Period.all
  end

  def show
  end

  def create
    @period = Period.new(period_params)

    if @period.save
      render :show, status: :created, location: @period
    else
      render json: @period.errors, status: :unprocessable_entity
    end
  end

  def search
    @periods = Company.find(params[:company_id]).periods.distinct

    render :index, status: :ok
  end

  def update
    if @period.update(period_params)
      render :show, status: :ok, location: @period
    else
      render json: @period.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @period.destroy
  end

  private

    def set_period
      @period = Period.find(params[:id])
    end

    def period_params
      params.require(:period).permit(:initial_date, :final_date, :description)
    end
end
