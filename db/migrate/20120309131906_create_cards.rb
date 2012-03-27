class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :number
      t.string :name
      t.string :card_type
      t.string :monster_type
      t.integer :monster_atk
      t.integer :monster_def
      t.string :monster_attribute
      t.string :type
      t.integer :monster_level
      t.text :lore
      t.integer :status
      t.string :stats
      t.string :archetypes
      t.string :mediums
      t.integer :tokens
    end
    add_index :cards, :number
    add_index :cards, :name
    add_index :cards, :card_type
  end
end
