class ApplicationController < ActionController::Base
    protect_from_forgery
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  


    def not_found
        raise ActionController::RoutingError.new('Not Found')
    rescue
        render_404
    end
    def render_404
        render file: "/#{Rails.root}/public/404.html", status: :not_found
    end  
    private      
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    def authorize
        redirect_to login_url, alert: "Not authorized" if current_user.nil?
    end
    def clear_flash
        flash[:status] = nil
    end
end
