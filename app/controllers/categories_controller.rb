# frozen_string_literal: true

class CategoriesController < ApplicationController
  def search
    @sub_category = Category.where("parent_id = ?", params[:id])
  end
end
