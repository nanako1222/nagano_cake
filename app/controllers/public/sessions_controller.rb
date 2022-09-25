class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
    def customer_state
      @customer = Customer.find_by(email: params[:customer][:email])
      if @customer
        if @customer.valid_password?(params[:customer][:password]) && !@customer.is_valid
          redirect_to new_customer_session_path, notice: 'こちらのユーザーは既に退会済みです'
        # else
        #   redirect_to new_customer_session_path, notice: 'こちらのユーザーは既に退会済みです'
        end
      end
    end

    private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :password_confirmation, :postal_code, :adress, :telephone_number)
    end

      # # ture && true
      # if @customer && @customer.valid_password?(params[:customer][:password]) && !@customer.is_active
      #   redirect_to new_user_session_path
      # end
      # # true && flase
      # if @customer && !(@customer.valid_password?(params[:customer][:password]) && !@customer.is_active)
      #   redirect_to new_user_session_path
      # end
end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])

