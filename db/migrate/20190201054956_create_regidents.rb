class CreateRegidents < ActiveRecord::Migration[5.2]
  def change
    create_table :regidents do |t|
      t.string :real_name, null:false
      t.string :kana_name, null:false
      t.datetime :birthday, null:false
      t.integer :zip_code, null:false
      t.integer :prefecture, null:false
      t.string :city_name, null:false
      t.string :house_number
      t.string :building_name
      t.integer :phone_number

      t.timestamps
    end
  end
end
