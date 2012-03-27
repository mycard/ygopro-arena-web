class CreateDuels < ActiveRecord::Migration
  def change
    create_table :duels do |t|
      t.references :user1
      t.references :user2
      t.references :winner
      t.integer :winreason
      t.string :replay
      t.integer :user1_credits
      t.integer :user2_credits

      t.timestamps
    end
    add_index :duels, :user1_id
    add_index :duels, :user2_id
  end
end
