class CreatePayrollDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :payroll_details do |t|
      t.string :concept
      t.bigint :valor
      t.integer :type
      t.float :percentage
      t.references :payroll, null: false, foreign_key: true

      t.timestamps
    end
  end
end
