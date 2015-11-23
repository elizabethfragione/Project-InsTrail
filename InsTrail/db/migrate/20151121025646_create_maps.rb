class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|

      t.timestamps null: false
      t.boolean :authenticated
      t.string :kind
    end
  end
end
