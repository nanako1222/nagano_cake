class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @order.save
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    elsif params[:order][:address_option] = "1"
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
      @ordered_item = OrderedItem.new
      @ordered_item.order_id =  @order.id
      @ordered_item.item_id = cart_item.item_id
      @ordered_item.amount = cart_item.amount
      @ordered_item.tax_included_price = cart_item.item.with_tax_price
      @ordered_item.save
    end
      current_customer.cart_items.destroy_all
      redirect_to public_orders_thanks_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items
  end

  private
    def order_params
        params.require(:order).permit(:carriage, :payment, :name, :address, :postal_code ,:customer_id,:total_price)
    end
    private

end
