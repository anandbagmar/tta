class CreateUnitTestXmls < ActiveRecord::Migration
  def change
    create_table :unit_test_xmls do |t|
      t.string :xml_file_name
      t.string :xml_content_type
      t.string :xml_file_size
      t.datetime :xml_updated_at
      t.timestamps
    end
  end
end
