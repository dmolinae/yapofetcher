class CreateHouses < ActiveRecord::Migration[5.0]
  def change
    create_table :houses do |t|
      t.string :title
      t.integer :price
      t.integer :rooms
      t.string :url

      t.timestamps
    end
  end
end
