class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :null => false
      t.string :nickname, :default => '', :null => false
      t.string :password, :null => false
      t.string :email, :default => '', :null => false
      t.references :usergroup, :default => '', :null => false
      t.references :admingroup, :default => '', :null => false
      t.string :regip, :default => '', :null => false
      t.string :lastloginip, :default => '', :null => false
      t.integer :readnum, :default => 0, :null => false
      t.integer :viewnum, :default => 0, :null => false
      t.integer :onlinetime, :default => 0, :null => false
      t.integer :credit, :default => 0, :null => false
      t.integer :credit1, :default => 0, :null => false
      t.integer :credit2, :default => 0, :null => false
      t.integer :credit3, :default => 0, :null => false
      t.integer :credit4, :default => 0, :null => false
      t.integer :credit5, :default => 0, :null => false
      t.integer :credit6, :default => 0, :null => false
      t.integer :credit7, :default => 0, :null => false
      t.integer :credit8, :default => 0, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
