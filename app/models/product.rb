# frozen_string_literal: true

class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :category
  belongs_to :user
  has_many :product_users
  has_many :users, through: :product_users

  enum condition: ["新品", "目立った傷や汚れなし"]
  enum derivery_way: ["送料込み（出品者負担）", "着払い（購入者負担）"]
  enum derivery_source: ["北海道", "沖縄"]
  enum derivery_day: ["1-2日で発送", "2-3日で発送", "4-7日で発送"]

  validates :name,
            :description,
            :price,
            :category_id,
            :condition,
            :derivery_source,
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
