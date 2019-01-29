# frozen_string_literal: true

class ProductsController < ApplicationController
  def index; end

  def show; end

  def new
    @product = Product.new
    @categories = Category.where("parent_id = ?", 0)
  end

  def create
    # @product = Product.new(name:"test", description:"test teext", condition:1, derivery_way:2, derivery_source:3, derivery_day:3, price:333, category_id:0)
    @product = Product.new(product_params)
    @categories = Category.where("parent_id = ?", 0)
    unless params[:product][:images].nil?
      @product.images.attach(params[:product][:images])
    end

    if @product.save
      respond_to do |format|
        format.html { render template: "products/create.html.erb" }
        format.json { render template: "products/create.html.erb" }
      end
    else
      render :new
    end
  end

  protected
  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :condition,
      :category_id,
      :derivery_way,
      :derivery_source,
      :derivery_day,
      :price,
      images:[])
  end
end
