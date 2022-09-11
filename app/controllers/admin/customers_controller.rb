class Admin::CustomersController < ApplicationController
  def index
    @customer = Customer.new
    @customers = Customer.page(params[:page])
  end
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
  end

  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :postal_code, :adress, :telephone_number)
    end
end
