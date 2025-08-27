# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "Você não tem permissão para acessar esta página."
  end


  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(resource)
    accounts_path # ou dashboard_path se tiver um DashboardController
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
