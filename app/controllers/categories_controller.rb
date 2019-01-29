class CategoriesController < ApplicationController
  def search
    @sub_category = Category.where("parent_id = ?",params[:id])
  end
end
