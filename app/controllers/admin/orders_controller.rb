class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def update
  end

  private
    def order_params
        params.require(:order).permit(:payment_method, :carriage, :payment, :name, :address, :postal_code ,:customer_id,:total_price)
    end
end
