class UpdateTestMetaData < ActiveRecord::Migration
  def change
    add_column :test_metadata, :branch, :string
    rename_column :test_metadata, :browser, :browser_or_device
    rename_column :test_metadata, :type_of_environment, :environment
    rename_column :test_metadata, :os_name, :os
    rename_column :test_metadata, :host_name, :test_execution_machine_name
  end
end
