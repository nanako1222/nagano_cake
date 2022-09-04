class Public::CartItemsController < ApplicationController
  def index
    @cart_item = CartItem.new
    @cart_items = current_customer.cart_items.all
    @cart_items = Item.price
  end

  def update
  end

  def destroy
  end

  def destroy_all
    CartItem.destroy_all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item_exit1 = CartItem.find_by(item_id: @cart_item.item_id)
    if @cart_item.item_id == @cart_item_exit1.item_id
      @cart_item_exit = CartItem.find_by(item_id: @cart_item.item_id)
      @item_amount = @cart_item.amount + @cart_item_exit.amount
      @cart_item.update(amount: @item_amount)
    else
      @cart_item.save
    end
    redirect_to public_cart_items_path
  end

  private
    def cart_item_params
        params.require(:cart_item).permit(:item_id, :amount)
    end
end
