class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    # byebug
    case resource
    when Admin
      admin_path
    when Customer
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    # byebug binding.pry
    if resource == :admin
　　　　admin_path
    elsif resource == :customer
      root_path
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :adress, :telephone_number])
  end
end
