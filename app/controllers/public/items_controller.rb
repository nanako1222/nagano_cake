class Public::ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :price)
  end
end
