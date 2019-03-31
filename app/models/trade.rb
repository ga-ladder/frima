# frozen_string_literal: true

class Trade < ApplicationRecord
  belongs_to :user
  belongs_to :product

  #-------------status---------------
  # user_id: 購入者側（顧客）
  # 0: 売上
  # 1: 返品
  #----------------------------------
end
