class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :trail, index: true
      t.string :trail_name
      t.string :low_resolution_url
      t.string :thumbnail_url
      t.string :standard_resolution_url
      t.timestamps null: false
    end

  end
end
