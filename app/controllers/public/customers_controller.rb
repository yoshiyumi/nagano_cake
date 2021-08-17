class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
    if @customer.id == current_customer.id
      render :edit
    else
      redirect_to customers_my_page_path
    end

  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customers_my_page_path
    else
     render :edit
    end

  end

  def confirm
    @customer = current_customer
  end

  def withdraw
   @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name,:last_name,:first_name_kana,:last_name_kana,:email,:postal_code,:address,:telephone_number,:is_active)
  end
end
