class AddTestExecutionSummaryToTestMetadata < ActiveRecord::Migration
  def change
    add_column :test_metadata, :ci_build_number, :string, :default => ""
  end
end
