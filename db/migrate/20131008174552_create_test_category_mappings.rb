class CreateTestCategoryMappings < ActiveRecord::Migration
  def change
    create_table :test_category_mappings do |t|
      t.string :test_category
      t.string :test_sub_category

      t.timestamps
    end
  end
end
