class Public::ProductsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate!, except: [:index]

  def index
    @products = Product.all
    @products = Product.all.page(params[:page]).per(8)
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :image, :is_valid)
  end

end
