# frozen_string_literal: true

class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.references :user
      t.references :product
      t.string :charge_id

      t.timestamps
    end
  end
end
