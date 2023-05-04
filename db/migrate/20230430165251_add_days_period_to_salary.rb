class AddDaysPeriodToSalary < ActiveRecord::Migration[6.1]
  def change
    add_column :salaries, :days_period, :integer
  end
end
