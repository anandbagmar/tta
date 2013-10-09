class AddTestSubCategoryToTestMetadata < ActiveRecord::Migration
  def change
    add_column :test_metadata, :test_sub_category, :string
  end
end
