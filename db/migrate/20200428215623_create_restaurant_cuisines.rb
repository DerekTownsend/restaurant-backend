class CreateRestaurantCuisines < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurant_cuisines do |t|
      t.references :cuisine, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
