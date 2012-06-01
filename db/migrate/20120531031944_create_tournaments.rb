class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :location_type
      t.string :location
      t.text :note

      t.timestamps
    end
  end
end
