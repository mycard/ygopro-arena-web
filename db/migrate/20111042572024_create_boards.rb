class CreateBoards < ActiveRecord::Migration
  def self.up
    drop_table :boards  if self.table_exists?(:boards)
    
    create_table :boards do |t|
      t.string :name, :default => '', :null => false
      t.references :superboard, :null => false
      t.integer :displayorder, :default => '0', :null => false
      t.text :introduction, :default => '', :null => false
      t.text :notice, :default => '', :null => false
      t.string :logo, :default => '', :null => false
      t.string :banner, :default => '', :null => false
      t.integer :readperm, :default => 0, :null => false
      t.integer :topicperm, :default => 0, :null => false
      t.integer :postperm, :default => 0, :null => false


      t.timestamps
    end
  end

  def self.down
    drop_table :boards
  end
end
