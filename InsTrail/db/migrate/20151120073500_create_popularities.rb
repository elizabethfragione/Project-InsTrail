class CreatePopularities < ActiveRecord::Migration
  def change
    create_table :popularities do |t|

      t.timestamps null: false
    end
  end
end
