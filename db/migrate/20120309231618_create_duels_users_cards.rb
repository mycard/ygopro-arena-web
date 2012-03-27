class CreateDuelsUsersCards < ActiveRecord::Migration
  def change
    create_table :duels_users_cards do |t|
      t.references :duel
      t.references :user
      t.references :card
      t.boolean :main
    end
    add_index :duels_users_cards, :duel_id
    add_index :duels_users_cards, :user_id
    add_index :duels_users_cards, :card_id
  end
end
