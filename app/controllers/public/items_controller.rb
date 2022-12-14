class Public::ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.page(params[:page])
    @item_count = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private
  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :price)
  end
end
