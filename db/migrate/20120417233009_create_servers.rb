class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.string :password
      t.string :ip
      t.integer :port
      t.integer :http_port

      t.timestamps
    end
  end
end
