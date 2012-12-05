class CreateTestRecords < ActiveRecord::Migration
  def change
    create_table :test_records do |t|
      t.integer :test_metadatum_id
      t.string  :class_name
      t.integer :number_of_tests
      t.integer :number_of_errors
      t.integer :number_of_failures
      t.string  :time_taken

      t.timestamps
    end
  end
end
