class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|

      t.boolean :authenticated
      t.string :kind
      t.timestamps null: false
    end
  end
end
