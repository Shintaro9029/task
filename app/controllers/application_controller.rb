# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  # user_contorollerに継承させるために
  class Forbidden < ActionController::ActionControllerError
  end

  rescue_from Forbidden,                      with: :rescue403

  rescue_from Exception,                      with: :rescue500
  rescue_from ActiveRecord::RecordNotFound,   with: :rescue404
  rescue_from ActionController::RoutingError, with: :rescue404

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_path unless current_user
  end

  def rescue403
    render template: 'errors/forbidden', status: 403
  end

  def rescue404
    render template: 'errors/not_found', status: 404
  end

  def rescue500
    render template: 'errors/internal_sever_error', status: 500
  end
end
