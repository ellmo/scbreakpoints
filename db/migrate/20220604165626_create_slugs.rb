class CreateSlugs < ActiveRecord::Migration[6.0]
  def change
    create_table :slugs do |t|
      t.string :label
      t.integer :unit_id
    end
  end
end
