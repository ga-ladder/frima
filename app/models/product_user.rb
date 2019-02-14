# frozen_string_literal: true

class ProductUser < ApplicationRecord
  belongs_to :user
  belongs_to :product
end
