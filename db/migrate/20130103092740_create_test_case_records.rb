class CreateTestCaseRecords < ActiveRecord::Migration
  def change
    create_table :test_case_records do |t|
      t.string :class_name
      t.string :time_taken
      t.references :test_suite_record

      t.timestamps
    end
    add_index :test_case_records, :test_suite_record_id
  end
end
