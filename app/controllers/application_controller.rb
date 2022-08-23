class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when Public
      customer_registration_path
    end
  end

  def after_sign_out_path_for(resource)
    admin_path
  end
end
