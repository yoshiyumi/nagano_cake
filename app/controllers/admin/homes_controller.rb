class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
    @orders = Order.page(params[:page]).per(10)
  end

end
