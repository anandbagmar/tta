class AddDefaultForCibuildnumber < ActiveRecord::Migration
  def change
    change_column :test_metadata, :platform_id, :integer, null: false
    change_column :test_metadata, :os, :string, null: false
    change_column :test_metadata, :test_execution_machine_name, :string, null: false
    change_column :test_metadata, :browser_or_device, :string, null: false
    change_column :test_metadata, :environment, :string, null: false
    change_column :test_metadata, :test_category, :string, null: false
    change_column :test_metadata, :branch, :string, null: false
    change_column :test_metadata, :test_report_type, :string, null: false
    remove_column :test_metadata, :ci_build_number
    add_column :test_metadata, :ci_build_number, :string, null: true
    change_column :test_metadata, :date_of_execution, :date, null: false
  end
end
