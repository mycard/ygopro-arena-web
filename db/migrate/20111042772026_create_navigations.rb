class CreateNavigations < ActiveRecord::Migration
  def self.up
    create_table :navigations do |t|
      t.string :name
      t.string :url
      t.integer :displayorder
      t.references :usergroup
      t.references :super
      #t.timestamps
    end
  end

  def self.down
    drop_table :navigations
  end
end
