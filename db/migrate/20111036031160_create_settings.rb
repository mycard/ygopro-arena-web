class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings, :primary_key => :name do |t|
      t.text :value
    end
    change_column(:settings, :name, :string)
  end

  def self.down
    drop_table :settings
  end
end
