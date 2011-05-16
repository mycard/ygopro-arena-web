class CreatePms < ActiveRecord::Migration
  def self.up
    create_table :pms do |t|
      t.references :from_user, :null => false
      t.references :to_user, :null => false
      t.boolean :read, :null => false, :default => false
      t.text :content, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :pms
  end
end
