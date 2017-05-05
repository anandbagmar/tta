class RenameProjectsToProducts < ActiveRecord::Migration
  def change
    rename_table :projects, :products
    remove_column :products, :authorization_level, :string
    rename_table :sub_projects, :platforms
    rename_column :platforms, :project_id, :product_id
    rename_column :test_metadata, :sub_project_id, :platform_id
  end
end
