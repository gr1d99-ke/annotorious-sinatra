class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.text :image_data
      t.timestamps null: false
    end
  end
end
