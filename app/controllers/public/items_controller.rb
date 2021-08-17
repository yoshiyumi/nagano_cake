class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
    @genres = Genre.all
    @items = Item.page(params[:page]).per(12)
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end


end
