class CreateProjectDetails < ActiveRecord::Migration
  def change
    create_table :project_details do |t|
      t.string :Name
      t.string :Log_type

      t.timestamps
    end
  end
end
