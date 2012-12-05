class CreateProjectMetadata < ActiveRecord::Migration
  def change
    create_table :project_metadata do |t|
      t.integer :sub_project_id
      t.string :ci_job_name
      t.string :os_name
      t.string :host_name
      t.string :browser
      t.string :type_of_test
      t.string :type_of_environment
      t.date   :date_of_execution
      t.string :user_timezone

      t.timestamps
    end
  end
end
