class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.references :topic
      t.references :user
      t.text :content
      t.integer :displayorder
      t.integer :readperm
      t.boolean :private
      t.boolean :anonymous
      t.boolean :ubb
      t.boolean :html

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
