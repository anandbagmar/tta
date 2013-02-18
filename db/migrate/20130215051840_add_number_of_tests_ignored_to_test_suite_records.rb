class AddNumberOfTestsIgnoredToTestSuiteRecords < ActiveRecord::Migration
  def change
    add_column :test_suite_records, :number_of_tests_ignored, :integer
  end
end
