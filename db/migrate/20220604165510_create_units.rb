class CreateUnits < ActiveRecord::Migration[6.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :units do |t|
      t.string :name
      t.string :race
      t.integer :size, default: 0
      t.boolean :flying, default: false

      t.integer :hitpoints
      t.integer :armor, default: 0
      t.integer :shields, default: 0

      t.integer :g_damage
      t.integer :g_cooldown
      t.integer :g_attacks, default: 1
      t.integer :g_bonus, default: 1
      t.integer :g_type, default: 0

      t.integer :a_damage
      t.integer :a_cooldown
      t.integer :a_attacks, default: 1
      t.integer :a_bonus, default: 1
      t.integer :a_type, default: 0
    end
  end
end
