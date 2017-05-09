class AddStatusToTestCaseRecords < ActiveRecord::Migration
  def change
    add_column "test_case_records", :status, :string, :null => false, :default => "n/a"
  end
end
