class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]

  protected

  # Se você adicionou o campo 'name' ao User
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :email, :password, :password_confirmation ])
  end

  # Para permitir edição de campos adicionais
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :email, :password, :password_confirmation, :current_password ])
  end
end
