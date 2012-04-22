class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.references :library
      t.references :user
      t.references :duel

      t.timestamps
    end
    add_index :decks, :library_id
    add_index :decks, :user_id
    add_index :decks, :duel_id
  end
end
