class AddColumnsToPayroll < ActiveRecord::Migration[6.1]
  def change
    add_column :payrolls, :other_income, :bigint
    add_column :payrolls, :other_deductions, :bigint
    add_column :payrolls, :non_salaries, :bigint
  end
end
