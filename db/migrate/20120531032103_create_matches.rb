class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :player1
      t.integer :player1_score
      t.references :player2
      t.integer :player2_score
      t.integer :round
      t.references :duel1
      t.references :duel2
      t.references :duel3
      t.references :tournament

      t.timestamps
    end
    add_index :matches, :player1_id
    add_index :matches, :player2_id
    add_index :matches, :duel1_id
    add_index :matches, :duel2_id
    add_index :matches, :duel3_id
    add_index :matches, :tournament_id
  end
end
