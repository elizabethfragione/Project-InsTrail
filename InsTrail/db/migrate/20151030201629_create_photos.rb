class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |p|

#      p.trail_name
#      p.trail_location
#      p.photo_location
      
      p.timestamps null: false
    end
  end
end
