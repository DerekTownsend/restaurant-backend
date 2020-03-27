class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :bio
      t.string :address
      t.string :cuisine

      t.timestamps
    end
  end
end
