class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to public_customers_path, notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def confirm
    @customer = current_customer
  end

  def out
    @customer = current_customer
    @customer.update(is_valid: false)
    reset_session
    redirect_to root_path
  end

  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :postal_code, :adress, :telephone_number)
    end
end
