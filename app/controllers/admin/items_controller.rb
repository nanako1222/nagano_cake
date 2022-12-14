class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @item = Item.new
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id), notice: 'Product was successfully created'
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @item.image
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id), notice: 'Product was successfully updated'
    else
      render :show
    end
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price)
  end
end
