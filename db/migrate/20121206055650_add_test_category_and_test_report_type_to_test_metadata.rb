class AddTestCategoryAndTestReportTypeToTestMetadata < ActiveRecord::Migration
  def change
    add_column :test_metadata, :test_category, :string
    add_column :test_metadata, :test_report_type, :string
    remove_column :test_metadata, :type_of_test
    remove_column :test_metadata, :user_timezone
  end
end
