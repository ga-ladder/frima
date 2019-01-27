# frozen_string_literal: true

class ProductsController < ApplicationController
  def index; end

  def show; end

  def new
    @product = Product.new
    @categories = Category.where("parent_id = ?", 0)
  end

  def create
    # modal_create を render
  end
end
