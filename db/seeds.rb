# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Company.create(name: "Aleluya")

User.create(email: "peter@mail.com", encrypted_password: "123456")
User.create(email: "marta@mail.com", encrypted_password: "123456")

Employee.create(name: "Jose", document: 625493765, company_id: 1)

Salary.create(base_salary: 1300000, initial_date: "2023-04-01", final_date: "2023-05-31", days_period: 30, employee_id: 1)

Period.create(initial_date: "2023-04-01", final_date: "2023-04-30", description: "Mes de Abril")
Period.create(initial_date: "2023-05-01", final_date: "2023-05-31", description: "Mes de Mayo")