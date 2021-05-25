class Public::HomesController < ApplicationController
  def top
    @products = Product.all.order(created_at: :desc)
    @slide_products = Product.find [1, 6, 12, 15]
  end
  def about
  end
end
