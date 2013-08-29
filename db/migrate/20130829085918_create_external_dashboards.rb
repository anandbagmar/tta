class CreateExternalDashboards < ActiveRecord::Migration
  def change
    create_table :external_dashboards do |t|
      t.text :name
      t.text :link

      t.timestamps
    end
  end
end
