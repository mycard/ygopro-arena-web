class CreateModerations < ActiveRecord::Migration
  def self.up
    create_table :moderations do |t|
      t.references :user
      t.references :association, :polymorphic => true
      t.string :action
      t.string :note

      t.timestamps
    end
  end

  def self.down
    drop_table :moderations
  end
end
