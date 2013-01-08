class AddErrorMessageToTestCaseRecord < ActiveRecord::Migration
  def change
    add_column :test_case_records, :error_msg, :string
  end
end
