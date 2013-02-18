class AddNumberOfTestsNotRunToTestSuiteRecords < ActiveRecord::Migration
  def change
    add_column :test_suite_records, :number_of_tests_not_run, :integer
  end
end
