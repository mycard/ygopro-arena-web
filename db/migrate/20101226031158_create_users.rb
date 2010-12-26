class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.string :password
      t.string :email
      t.references :usergroup
      t.references :admingroup
      t.string :regip
      t.string :lastloginip
      t.integer :readnum
      t.integer :viewnum
      t.integer :onlinetime
      t.integer :credit
      t.integer :credit1
      t.integer :credit2
      t.integer :credit3
      t.integer :credit4
      t.integer :credit5
      t.integer :credit6
      t.integer :credit7
      t.integer :credit8
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
