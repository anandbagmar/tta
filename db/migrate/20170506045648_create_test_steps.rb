class CreateTestSteps < ActiveRecord::Migration
  def change
    create_table :test_steps_records do |t|
      t.references :test_case_records
      t.string :step_name
      t.string :step_description
      t.string :status
      t.string :time_taken
      t.timestamps
    end
  end
end
