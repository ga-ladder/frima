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
    @categories = Category.root_set
    @product = Product.new(product_params)

    if params[:product][:images]
      if @product.save
        render :create
      else
        @product.images.purge if @product.images.attached?
        render :new
      end
    else
      @product.valid?
      @product.errors.add(:images, "Images can't be blank")
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
