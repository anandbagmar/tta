class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :type_of_test
      t.string :authorization_level

      t.timestamps
    end
  end
end
