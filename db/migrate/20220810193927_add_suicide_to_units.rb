class AddSuicideToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :suicide, :boolean, default: false
  end
end
