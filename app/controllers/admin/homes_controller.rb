class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders_index = Order.all.order("created_at DESC").page(params[:page])
  end
end
