class Period < ApplicationRecord
    has_many :payrolls
    has_many :companies, through: :payrolls

    validates :initial_date, :final_date, :description, presence: true

    before_create :validate_exists

    def validate_exists
      periods = Period.all

      periods.each do |period|
        if period.initial_date >= self.initial_date && period.initial_date <= self.final_date
          raise ArgumentError.new("Ya existe un periodo asignado del #{period.initial_date} al #{period.final_date}")
        end
      end
    end
end
