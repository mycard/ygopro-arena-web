class CreatePms < ActiveRecord::Migration
  def self.up
    create_table :pms do |t|
      t.references :user
      t.references :from_user
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :pms
  end
end
