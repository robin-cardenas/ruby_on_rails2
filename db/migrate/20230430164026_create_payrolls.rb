class CreatePayrolls < ActiveRecord::Migration[6.1]
  def change
    create_table :payrolls do |t|
      t.bigint :income
      t.bigint :deductions
      t.bigint :social_security
      t.bigint :parafiscal_contributions
      t.bigint :social_benefits
      t.bigint :employee_pay
      t.bigint :total_cost
      t.references :employee, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
