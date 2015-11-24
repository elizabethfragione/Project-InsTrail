class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.references :map, index: true
      t.string :name, null: false
      t.boolean :user
      t.float :lat
      t.float :lon
      t.integer :count
      t.timestamps null: false
    end

    add_index :trails, :name, unique: true
  end
end