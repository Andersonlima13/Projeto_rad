# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(resource)
    accounts_path # ou dashboard_path se tiver um DashboardController
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
