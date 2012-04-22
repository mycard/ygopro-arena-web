class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :name
      t.text :contents
      t.references :parent

      t.timestamps
    end
    add_index :libraries, :parent_id
    libraries = {}
    YAML.load_file('config/deck.yml').each do |key, values|
      libraries[key] = Library.create(name: key, contents:nil, parent: libraries[values.first["parent"]])
    end
  end
end
