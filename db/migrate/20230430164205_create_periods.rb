class CreatePeriods < ActiveRecord::Migration[6.1]
  def change
    create_table :periods do |t|
      t.date :initial_date
      t.date :final_date
      t.text :description

      t.timestamps
    end
  end
end
