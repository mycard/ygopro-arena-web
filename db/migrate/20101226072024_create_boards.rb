class CreateBoards < ActiveRecord::Migration
  def self.up
    create_table :boards do |t|
      t.string :name
      t.text :introduction
      t.text :notice
      t.string :logo
      t.string :banner
      t.integer :readperm
      t.integer :topicperm
      t.integer :postperm

      t.timestamps
    end
  end

  def self.down
    drop_table :boards
  end
end
