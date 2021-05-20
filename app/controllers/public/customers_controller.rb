class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
    render "edit"
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to customers_path(@customer.id)
  end

  def quit
  end

  def out
    customer = current_customer
    customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
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
