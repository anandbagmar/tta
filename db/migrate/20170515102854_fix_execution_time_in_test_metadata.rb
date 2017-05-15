class FixExecutionTimeInTestMetadata < ActiveRecord::Migration
  def change
    change_column :test_metadata, :date_of_execution, :datetime, null: false
  end
end
