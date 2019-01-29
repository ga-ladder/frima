# frozen_string_literal: true

class Product < ApplicationRecord
  has_many_attached :images

  validates :name,
            :description,
            :price,
            :category_id,
            :condition,
            :derivery_way,
            :derivery_day,
            presence: true
  validates :name, length: { maximum: 10 }
  validates :price, numericality: {
    only_integer: true,
    greater_than: 300,
    less_than: 999_999_999
  }
end
