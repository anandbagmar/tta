class UpdateTestStepRecord < ActiveRecord::Migration
  def change
    rename_table :test_steps_records, :test_step_records
    remove_column :test_step_records, :step_description
    add_column :test_step_records, :error_msg, :text, :null => true
    rename_column :test_step_records, :test_case_records_id, :test_case_record_id
  end
end
