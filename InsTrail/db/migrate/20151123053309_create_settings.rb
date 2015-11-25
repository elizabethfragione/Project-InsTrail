class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :number
      t.timestamps null: false
      t.references :user
    end
  end
end
