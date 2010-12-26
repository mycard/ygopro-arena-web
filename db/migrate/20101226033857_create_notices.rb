class CreateNotices < ActiveRecord::Migration
  def self.up
    create_table :notices do |t|
      t.references :user
      t.string :type
      t.references :assocaion, :polymorphic => true
      t.references :from_user
      t.timestamps
    end
  end

  def self.down
    drop_table :notices
  end
end
