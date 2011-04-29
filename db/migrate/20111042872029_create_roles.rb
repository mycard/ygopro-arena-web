class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name, :null => false
      t.boolean :topic_delete, :null => false, :default => false
      t.integer :topic_digest, :null => false, :default => 0
      t.integer :topic_displayorder, :null => false, :default => 0
      t.boolean :topic_highlight, :null => false, :default => false
      t.boolean :topic_edit, :null => false, :default => false
      t.boolean :topic_lock, :null => false, :default => false
    end
  end

  def self.down
    drop_table :roles
  end
end
