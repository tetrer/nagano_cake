class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
    render "edit"
  end

  def update

  end

  def quit

  end

  def out

  end


  private

  def customer_params
    params.require(:customer).permit(:last_name,
                                     :first_name,
                                     :kana_last_name,
                                     :kana_first_name,
                                     :postal_code,
                                     :address,
                                     :phone_number,
                                     :email)
  end


end
