# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.integer :bland_id, null: true, index: true
      t.integer :category_id, null: false, index: true
      t.integer :condition, null: false
      t.integer :derivery_source, null: false
      t.integer :derivery_way, null: false
      t.integer :derivery_day, null: false

      t.timestamps
    end
  end
end
