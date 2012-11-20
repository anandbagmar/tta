class CreateUnitTestRecords < ActiveRecord::Migration
  def change
    create_table :unit_test_records do |t|
      t.integer :project_id
      t.integer :project_meta_data_id
      t.string :class_name
      t.integer :number_of_tests
      t.integer :number_of_errors
      t.integer :number_of_failures
      t.string :time_taken

      t.timestamps
    end
  end
end
