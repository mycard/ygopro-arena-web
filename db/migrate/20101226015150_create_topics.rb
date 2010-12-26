class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.references :user
      t.references :type
      t.references :category, :polymorphic => true
      t.string :name
      t.integer :displayorder
      t.integer :views
      t.integer :readperm
      t.boolean :locked
      t.boolean :reverse
      t.boolean :private

      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
