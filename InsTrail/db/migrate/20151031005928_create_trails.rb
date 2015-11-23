class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|

      t.timestamps null: false
      t.string :name
      t.integer :count
      t.boolean :user
      t.float :lat
      t.float :lon
      t.references :map
    end
  end
end
