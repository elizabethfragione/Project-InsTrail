class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|

      t.boolean :authenticated, null: false
      t.string :kind
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
