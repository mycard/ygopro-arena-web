class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.references :user, :null => false
      t.references :type
      t.references :category, :polymorphic => true, :null => false
      t.string :name, :null => false
      t.boolean :digest, :default => false, :null => false
      t.integer :displayorder, :default => 0, :null => false
      t.integer :highlight, :default => 0, :null => false
      t.integer :viewnum, :default => 0, :null => false
      t.integer :readperm, :default => 1, :null => false
      t.boolean :locked, :default => false, :null => false
      t.boolean :deleted, :default => false, :null => false
      t.boolean :reverse, :default => false, :null => false
      t.boolean :private, :default => false, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
