# frozen_string_literal: true

class Resident < ApplicationRecord
  belongs_to :user

  validates :real_first_name,
            :real_last_name,
            :kana_first_name,
            :kana_last_name,
            :zip_code,
            :prefecture,
            :city_name,
            :house_number,
            presence: true
  validates :kana_first_name,
            :kana_last_name,
            format:
  { with: /\A[ｱ-ﾝア-ン]+\z/,
    message: "は，カタカナのみが使用できます" }

  enum derivery_source: %w[北海道 沖縄], _suffix: true
  enum prefecture: %w[北海道 沖縄], _prefix: :derivery_sources
end

