class CreateProjectMetadata < ActiveRecord::Migration
  def change
    create_table :project_metadata do |t|
      t.integer :project_id
      t.string :os_name
      t.string :host_name
      t.string :browser
      t.date :date_of_execution
      t.string :user_timezone

      t.timestamps
    end
  end
end
