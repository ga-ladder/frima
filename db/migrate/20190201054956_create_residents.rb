# frozen_string_literal: true

class CreateResidents < ActiveRecord::Migration[5.2]
  def change
    create_table :residents do |t|
      t.string :real_first_name, null: false
      t.string :real_last_name, null: false
      t.string :kana_first_name, null: false
      t.string :kana_last_name, null: false
      t.datetime :birthday
      t.integer :zip_code, null: false
      t.integer :prefecture, null: false
      t.string :city_name, null: false
      t.string :house_number
      t.string :building_name
      t.integer :phone_number

      t.timestamps
    end
  end
end
