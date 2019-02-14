class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :customer_id
      t.references :user

      t.timestamps
    end
  end
end
