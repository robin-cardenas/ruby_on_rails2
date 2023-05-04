class Salary < ApplicationRecord
  belongs_to :employee

  validates :days_period, :initial_date, :final_date, :employee_id, :base_salary, presence: true
  validates :days_period, :employee_id, :base_salary, numericality: true

  before_create :validate_exists

  def validate_exists
    employee = Employee.find(self.employee_id)

    employee.salaries.each do |salary|
      if self.initial_date >= salary.initial_date && self.initial_date <= salary.final_date
        raise ArgumentError.new("El empleado ya tiene un salario asignado para el periodo #{salary.initial_date} al #{salary.final_date}")
      end
    end
  end
end
