class Admin::SearchesController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "Customer"
      @customers = Customer.looks(params[:word])
    else
      @products = Product.looks(params[:word])
    end


  end
end
