# frozen_string_literal: true

class ProductsController < ApplicationController
  def index; end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @categories = Category.root_set
  end

  def create
    @product = Product.new(product_params)
    @product.images.attach(params[:product][:images]) unless params[:product][:images].nil?

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
      images: []
    )
  end
end
