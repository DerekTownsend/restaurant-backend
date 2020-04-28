class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :bio
      t.string :address
      t.string :city
      t.string :cuisine
      t.string :zipcode
      t.string :thumbnail      
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
