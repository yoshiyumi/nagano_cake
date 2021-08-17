class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def create
      @new_cart_item = current_customer.cart_items.new(cart_item_params)
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @cart_items.each do |cart_item|
         if @new_cart_item.item_id == cart_item.item_id
             new_amount = @new_cart_item.amount + cart_item.amount
             cart_item.update(amount: new_amount)
             @new_cart_item.delete
         end
      end


      @new_cart_item.save
      redirect_to cart_items_path
     

  end

  def update
    @cart_item = CartItem.find(params[:id])
    if  @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
     render :index
    end
  end

  def destroy
   @cart_item = CartItem.find(params[:id])
   @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_item = CartItem.where(customer_id: current_customer.id)
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
     params.require(:cart_item).permit(:item_id,:customer_id,:amount)
  end
end
