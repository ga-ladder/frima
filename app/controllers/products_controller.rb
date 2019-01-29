# frozen_string_literal: true

class ProductsController < ApplicationController
  def index; end

  def show; end

  def new
    @product = Product.new
    @categories = Category.where("parent_id = ?", 0)
  end

  def create
    @product = Product.new(product_params)
    unless params[:product][:images].nil?
      @product.images.attach(params[:product][:images])
    end

    if @product.save
      respond_to do |format|
        format.html { render template: "products/create.html.erb" }
        format.json { render template: "products/create.html.erb" }
      end
    else
      flash[:notice] = 'not yet'
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
