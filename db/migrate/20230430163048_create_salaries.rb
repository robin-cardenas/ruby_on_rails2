class CreateSalaries < ActiveRecord::Migration[6.1]
  def change
    create_table :salaries do |t|
      t.bigint :base_salary
      t.date :initial_date
      t.date :final_date
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
