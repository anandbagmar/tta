class AddPlatformVersionToTestMetadata < ActiveRecord::Migration
  def change
    add_column :test_metadata, :platform_version, :string, :null => false
  end
end
