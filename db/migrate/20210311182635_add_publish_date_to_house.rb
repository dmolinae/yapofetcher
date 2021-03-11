class AddPublishDateToHouse < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :publish_date, :datetime
  end
end
