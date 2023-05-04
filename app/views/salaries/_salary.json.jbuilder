json.data do
  json.extract! salary, :id, :base_salary, :initial_date, :final_date
  json.employee salary.employee.name
end
