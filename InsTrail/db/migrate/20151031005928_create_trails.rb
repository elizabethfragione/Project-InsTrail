class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.references :map, index: true
      t.string :name, null: false
      t.integer :user_id, null: false
      t.float :lat
      t.float :lon
      t.integer :count
      t.timestamps null: false
    end

    #add_index :trails, :name, unique: true
    #add_index :trails, :user_id, unique: true
    add_index :trails, [:name, :user_id], unique: true
  end
end