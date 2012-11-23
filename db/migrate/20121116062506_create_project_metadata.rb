class CreateProjectMetadata < ActiveRecord::Migration
  def change
    create_table :project_metadata do |t|
      t.integer :project_id
      t.string :sub_project_name
      t.string :os_name
      t.string :host_name
      t.string :browser
      t.string :type_of_enviornment
      t.date :date_of_execution
      t.string :user_timezone

      t.timestamps
    end
  end
end
