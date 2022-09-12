class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @order.save
    if params[:order][:address_method] == "own_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    elsif params[:order][:address_method] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render 'new'
    end
    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_customer.id
    @cart_total = 0
    @order.carriage = 800
    @order.total_price = @order.carriage + @cart_total
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    current_customer.cart_items.each do |cart_item|
      @ordered_item = OrderDetail.new
      @ordered_item.order_id =  @order.id
      @ordered_item.item_id = cart_item.item_id
      @ordered_item.amount = cart_item.amount
      @ordered_item.price = cart_item.item.with_tax_price
      @ordered_item.save
    end
      current_customer.cart_items.destroy_all
      redirect_to orders_thanks_path
  end

  def index
    @orders = current_customer.orders.page(params[:page])

  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  private
    def order_params
        params.require(:order).permit(:payment_method, :carriage, :payment, :name, :address, :postal_code ,:customer_id,:total_price)
    end

end
