class CreateReferees < ActiveRecord::Migration
  def change
    create_table :referees do |t|
      t.references :user
      t.references :tournament

      t.timestamps
    end
    add_index :referees, :user_id
    add_index :referees, :tournament_id
  end
end
