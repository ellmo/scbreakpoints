class CreateUnits < ActiveRecord::Migration[6.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :units do |t|
      t.string :name
      t.string :race
      t.integer :size, default: 1
      t.boolean :flying, default: false

      t.integer :hitpoints
      t.integer :armor, default: 0
      t.integer :shields, default: 0

      t.integer :g_damage
      t.integer :g_attacks
      t.integer :g_bonus
      t.integer :g_cooldown

      t.integer :a_damage
      t.integer :a_attacks
      t.integer :a_bonus
      t.integer :a_cooldown
    end
  end
end
