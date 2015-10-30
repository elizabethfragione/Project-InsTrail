class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |p|

      p.trail_name :trail_name
      p.get_trail_location :trail_location
      p.get_photo_location :photo_location
      
      p.timestamps null: false
    end
  end
end
