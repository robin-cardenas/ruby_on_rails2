json.data do
  json.extract! employee, :id, :name, :document
  json.company employee.company.name
end
