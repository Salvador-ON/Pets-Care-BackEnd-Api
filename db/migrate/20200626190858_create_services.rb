class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.string :image_url

      t.timestamps
    end
  end
end
