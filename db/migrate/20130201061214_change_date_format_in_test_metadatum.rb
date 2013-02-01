class ChangeDateFormatInTestMetadatum < ActiveRecord::Migration
  def up
    change_column :test_metadata, :date_of_execution, :datetime
  end

  def down
    change_column :test_metadata, :date_of_execution, :date
  end
end
