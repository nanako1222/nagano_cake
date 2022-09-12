class Public::CartItemsController < ApplicationController
  def index
    @cart_item = CartItem.new
    @cart_items = current_customer.cart_items.all
    @cart_total = 0
  end

  def update
    @cart_items = current_customer.cart_items.find(params[:id])
    if @cart_items.update(cart_item_params)
      redirect_to cart_items_path
    end
  end

  def destroy
    @cart_items = current_customer.cart_items.find(params[:id])
    if @cart_items.destroy
      redirect_to cart_items_path
    end
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    # @cart_item = CartItem.new(cart_item_params)
    # @cart_item.customer_id = current_customer.id
    # @cart_item_exit = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    # if @cart_item_exit.present?
    #   @cart_item.amount + @cart_item_exit.amount = @cart_item.amount

    #   @cart_item_exit.destroy
    # end
    # @cart_item.save

    # redirect_to public_cart_items_path
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item_exist = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
    if @cart_item_exist
      @item_amount = @cart_item.amount + @cart_item_exist.amount
      @cart_item_exist.update(amount: @item_amount)
    else
      @cart_item.save
    end
    redirect_to cart_items_path
  end

  private
    def cart_item_params
        params.require(:cart_item).permit(:item_id, :amount)
    end
end
