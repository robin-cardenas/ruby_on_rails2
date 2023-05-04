class Payroll < ApplicationRecord
  has_many :payroll_details

  belongs_to :employee
  belongs_to :company
  belongs_to :period

  validates :employee_id, :company_id, :period_id, :other_income, :other_deductions, :non_salaries, presence: true
  validates :employee_id, :company_id, :period_id, :other_income, :other_deductions, :non_salaries, numericality: true

  before_create :validate_exists

  def settle_payroll
    nomina = NominaService.new
    employee = Employee.find(self.employee_id)

    validate_salary(employee)

    salary = nomina.salary(employee.salaries.last.base_salary, employee.salaries.last.days_period)

    total_ss_parafiscal = self.other_income + salary
    total_social_benefits = nomina.total_social_benefits(total_ss_parafiscal, employee.salaries.last.base_salary, employee.salaries.last.days_period)
    total_income = nomina.total_income(self.non_salaries, total_social_benefits)
    
    social_security = nomina.social_security(total_ss_parafiscal)
    parafiscal_contributions = nomina.parafiscal_contributions(total_ss_parafiscal)
    social_benefits = nomina.social_benefits(total_ss_parafiscal)

    deductions = nomina.deductions(total_ss_parafiscal, self.other_deductions)

    employee_pay = total_income - deductions
    total_company_cost = total_income + social_security + parafiscal_contributions + social_benefits

    validate_employee_pay(employee_pay)

    self.update(income: total_income, deductions: deductions, social_security: social_security, parafiscal_contributions: parafiscal_contributions, social_benefits: social_benefits, employee_pay: employee_pay, total_cost: total_company_cost)

    PayrollDetail.create(concept: 'salary', valor: salary, payroll_id: self.id)
    PayrollDetail.create(concept: 'Total base SS y parafiscales', valor: total_ss_parafiscal, payroll_id: self.id)
    PayrollDetail.create(concept: 'Total base social benefits', valor: total_social_benefits, payroll_id: self.id)
    PayrollDetail.create(concept: 'Health', valor: nomina.health_deduction, payroll_id: self.id)
    PayrollDetail.create(concept: 'Pension', valor: nomina.pension_deduction, payroll_id: self.id)
    PayrollDetail.create(concept: 'Fondo de solidaridad', valor: nomina.solidarity_fund, payroll_id: self.id)
    PayrollDetail.create(concept: 'cuenta de subsistencia', valor: nomina.subsistence_account, payroll_id: self.id)
    PayrollDetail.create(concept: 'otras deducciones', valor: self.other_deductions, payroll_id: self.id)
    PayrollDetail.create(concept: 'Health', valor: nomina.health_security, payroll_id: self.id)
    PayrollDetail.create(concept: 'Pension', valor: nomina.pension_security, payroll_id: self.id)
    PayrollDetail.create(concept: 'ARL', valor: nomina.arl, payroll_id: self.id)
    PayrollDetail.create(concept: 'Caja de compensación', valor: nomina.compensation_box, payroll_id: self.id)
    PayrollDetail.create(concept: 'ICBF', valor: nomina.icbf, payroll_id: self.id)
    PayrollDetail.create(concept: 'Sena', valor: nomina.sena, payroll_id: self.id)
    PayrollDetail.create(concept: 'Cesantías', valor: nomina.layoffs, payroll_id: self.id)
    PayrollDetail.create(concept: 'Intereses sobre las cesantías', valor: nomina.interest_layoffs, payroll_id: self.id)
    PayrollDetail.create(concept: 'Prima de servicios', valor: nomina.premium_services, payroll_id: self.id)
    PayrollDetail.create(concept: 'Vacaciones', valor: nomina.vacation, payroll_id: self.id)
  end

  def validate_salary(employee)
    if employee.salaries.count() == 0
      raise ArgumentError.new("El empleado no tiene asignado un salario")
    end
  end

  def validate_employee_pay(employee_pay)
    if employee_pay <= 0
      raise ArgumentError.new("El pago del empleado no puede ser cero o negativo")
    end
  end

  def validate_exists
    employee = Employee.find(self.employee_id)

    employee.payrolls.each do |payroll|
      if payroll.period_id == self.period_id
        raise ArgumentError.new("No se puede crear dos nominas en un mismo periodo")
      end
    end
  end

end
