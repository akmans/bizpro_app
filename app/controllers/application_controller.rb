class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper, ApplicationHelper
  
  private
  
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in_help?
        store_location_help
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
  
    # Redirects to stored location (or to the default).
    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end
end
