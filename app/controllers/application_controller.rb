class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_filter :get_user_status
  def get_user_status
    if signed_in? and !current_user.active
      sign_out(current_user)
      redirect_to root_path, alert: 'Tu cuenta ha sido desactivada porfavor contactanos para reactivar tu cuenta.'
    end
  end
  
#  if Rails.env == "production" or Rails.env == "development"
#    rescue_from Exception do |exception|
#      manage_exception(exception, 1)
#    end
#    rescue_from ActiveRecord::RecordNotFound do |exception|
#      manage_exception(exception, 2)
#    end
#    rescue_from ActionController::RoutingError do |exception|
#      manage_exception(exception, 3)
#    end
#    rescue_from ActionController::ActionControllerError do |exception|
#      manage_exception(exception, 4)
#    end 
#    rescue_from AbstractController::DoubleRenderError do |exception|
#      manage_exception(exception, 5)
#    end
#  end
#
#  def manage_exception(exception, code)
#    line_number = exception.backtrace.to_s.split(":in").first.gsub("[\"", "")
#    if exception.to_s == 'You are not authorized to access this page.'
#      flash[:alert] =  "La página solicitada no existe."
#      redirect_to root_path
#    else
#      flash[:error] = Rails.env.development? ? "Something went wrong: " + exception.to_s + " in " + line_number : "Un error inesperado ha ocurrido (#{exception.to_s}). Por favor, contáctanos."
#      redirect_to root_path
#    end
#  end
end
