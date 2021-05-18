class Public::ProductsController < ApplicationController
  def index
    @products = Product.all
    @products = Product.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @product.save
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :image, :is_valid)
  end
  
end
