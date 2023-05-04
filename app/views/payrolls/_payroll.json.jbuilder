json.data do
  json.id @payroll.id
  json.employe @payroll.employee.name
  json.company @payroll.company.name
  json.period @payroll.period.description

  json.income do
    json.salary @payroll.payroll_details[0].valor
    json.other_income @payroll.other_income
    json.total_base_ss_parafiscal @payroll.payroll_details[1].valor
    json.total_base_social_benefits @payroll.payroll_details[2].valor
    json.non_salaries @payroll.non_salaries
    json.total_income @payroll.income
  end

  json.withholdings_deductions do
    json.health @payroll.payroll_details[3].valor
    json.pension @payroll.payroll_details[4].valor
    json.solidarity_fund @payroll.payroll_details[5].valor
    json.subsistence_account @payroll.payroll_details[6].valor
    json.other_deductions @payroll.other_deductions
    json.total_deductions @payroll.deductions
  end

  json.social_security do
    json.health @payroll.payroll_details[8].valor
    json.pension @payroll.payroll_details[9].valor
    json.arl @payroll.payroll_details[10].valor
    json.total_social_security @payroll.social_security
  end

  json.parafiscal_contributions do
    json.compensation_box @payroll.payroll_details[11].valor
    json.icbf @payroll.payroll_details[12].valor
    json.sena @payroll.payroll_details[13].valor
    json.total_parafiscal_contributions @payroll.parafiscal_contributions
  end

  json.social_benefits do
    json.layoffs @payroll.payroll_details[14].valor
    json.interest_layoffs @payroll.payroll_details[15].valor
    json.premium_services @payroll.payroll_details[16].valor
    json.vacations @payroll.payroll_details[17].valor
    json.total_social_benefits @payroll.social_benefits
  end

  json.totals do
    json.employee_pay @payroll.employee_pay
    json.total_cost @payroll.total_cost
  end
end
