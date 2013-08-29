class ChangeExternalDashboardColumnTypes < ActiveRecord::Migration
  def up
    change_column :external_dashboards, :name, :string

  end

  def down
    change_column :external_dashboards , :name, :string
  end
end


