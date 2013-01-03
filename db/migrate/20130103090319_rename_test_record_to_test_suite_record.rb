class RenameTestRecordToTestSuiteRecord < ActiveRecord::Migration
  def up
    rename_table :test_records, :test_suite_records
  end

  def down
    rename_table :test_suite_records, :test_records
  end
end
