class CreateModerators < ActiveRecord::Migration
  def change
    create_table :moderators do |t|
      t.references :user
      t.references :board

      t.timestamps
    end
    add_index :moderators, :user_id
    add_index :moderators, :board_id
  end
end
