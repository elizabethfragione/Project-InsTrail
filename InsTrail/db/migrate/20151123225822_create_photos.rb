class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :trail, index: true
      t.string :pid, null: false
      t.string :trail_name
      t.string :low_resolution_url
      t.string :thumbnail_url
      t.string :standard_resolution_url
      t.timestamps null: false
    end

    add_index :photos, :pid, unique: true
  end
end
