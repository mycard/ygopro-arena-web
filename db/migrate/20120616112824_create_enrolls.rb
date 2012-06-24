class CreateEnrolls < ActiveRecord::Migration
  def change
    create_table :enrolls do |t|
      t.references :tournament
      t.string :name
      t.references :user
      t.string :contact_type
      t.string :contact
      t.text :deck
      t.integer :score

      t.timestamps
    end
    add_index :enrolls, :tournament_id
    add_index :enrolls, :user_id
  end
end
