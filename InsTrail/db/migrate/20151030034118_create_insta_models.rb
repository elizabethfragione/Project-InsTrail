class CreateInstaModels < ActiveRecord::Migration
  def change
    create_table :insta_models do |t|
      t.text :recent_media
      t.timestamps null: false
    end
  end
end
