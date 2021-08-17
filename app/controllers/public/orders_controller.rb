class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def index
    @orders = Order.where(customer_id: current_customer.id)

  end

  def create
   @order = Order.new(order_params)
   @order.customer_id = current_customer.id
   @order.postage = 800
   @cart_items = CartItem.where(customer_id: current_customer.id)
   @order.total_payment = 0
   @cart_items.each do |cart_item|
      @order.total_payment += cart_item.item.with_tax_price*cart_item.amount
   end
   @order.status = "waiting_for_payment"

   if @order.save
     @cart_items.each do |cart_item|
       @order_detail = OrderDetail.new
       @order_detail.order_id = @order.id
       @order_detail.item_id = cart_item.item.id
       @order_detail.price = cart_item.item.with_tax_price
       @order_detail.amount = cart_item.amount
       @order_detail.making_status = "not_startable"

       @order_detail.save
     end
     @cart_items.destroy_all

     redirect_to thanks_orders_path
   else
     @order = Order.where(customer_id: current_customer.id)
     redirect_to confirm_orders_path
   end
  end



  def show
    if params[:id] == "confirm"
        return redirect_to new_order_path
    end
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
     @cart_items = CartItem.where(customer_id: current_customer.id)
     @order = Order.new(order_params)
     @order.postage = 800
     if params[:order][:my_address]  == "0"
     @order.name = current_customer.full_name
     @order.address = current_customer.address
     @order.postal_code = current_customer.postal_code

     elsif params[:order][:my_address]  == "1"
       if params[:order][:address_id] == nil
         redirect_to new_order_path
         return
       end

         @address = Address.find(params[:order][:address_id])
         @order.name = @address.name
         @order.address = @address.address
         @order.postal_code = @address.postal_code

     elsif params[:order][:my_address]  == "2"
       if params[:order][:name] == "" || params[:order][:postal_code] == "" || params[:order][:address] == ""
         redirect_to new_order_path

         return
       end


     end
  end

  def thanks

  end

  private
  def order_params
     params.require(:order).permit(:address,:postal_code,:name,:payment_method)
  end
end
