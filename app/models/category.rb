# frozen_string_literal: true

class Category < ApplicationRecord
  has_one :product

  def self.root_set
    where("parent_id = ?", 0)
  end
end
