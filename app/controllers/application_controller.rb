class ApplicationController < ActionController::Base
    helper_method :current_user
    before_action :login_required

    class Forbidden < ActionController::ActionControllerError
    end

    rescue_from Forbidden, with: :rescue403

    private

    def current_user
        @current_user||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def login_required
        redirect_to login_path unless current_user
    end

    def rescue403
        render template: 'errors/forbidden', status: 403
    end
end
