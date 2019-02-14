# frozen_string_literal: true

class CreateProductUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :product_users do |t|
      t.references :user
      t.references :product

      t.timestamps
    end
    # add_reference :product_users, :user, foreign_key: true
    # add_reference :product_users, :product, foreign_key: true
  end
end
