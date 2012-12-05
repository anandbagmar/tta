class CreateSubProjects < ActiveRecord::Migration
  def change
    create_table :sub_projects do |t|
      t.integer :project_id
      t.string :name

      t.timestamps
    end
  end
end
