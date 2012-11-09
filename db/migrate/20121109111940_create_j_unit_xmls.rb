class CreateJUnitXmls < ActiveRecord::Migration
  def change
    create_table :j_unit_xmls do |t|
      t.string :name
      t.text :contentxml

      t.timestamps
    end
  end
end
