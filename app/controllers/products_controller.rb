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
    @product = Product.new(name:"test", description:"test teext", condition:1, derivery_way:2, derivery_source:3, derivery_day:3, price:333, category_id:0)

    respond_to do |format|
      if @product.save
        format.html { render template: "products/create.html.erb" }
        format.json { render template: "products/create.html.erb" }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  protected
  def product_params
    params.require(:product).permit(:name, :description, :condition, :derivery_way, :derivery_source, :derivery_day, :price)
  end
end
