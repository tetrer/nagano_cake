class Public::ProductsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_customer!, only: [:show]

  def index
    @genres = Genre.all
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
