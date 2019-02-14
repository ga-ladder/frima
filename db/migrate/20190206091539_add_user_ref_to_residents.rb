# frozen_string_literal: true

class AddUserRefToResidents < ActiveRecord::Migration[5.2]
  def change
    add_reference :residents, :user, foreign_key: true
  end
end
