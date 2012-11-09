class CreateJunitXmlData < ActiveRecord::Migration
  def change
    create_table :junit_xml_data do |t|
      t.string :name
      t.string :classname
      t.string :tests
      t.string :failures
      t.string :errors
      t.string :hostname
      t.string :timetaken

      t.timestamps
    end
  end
end
