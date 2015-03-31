class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

	def index
	end

	private
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Please log in."
				redirect_to login_url
			end
		end
		

		def admin_user
			unless current_user.admin?
				flash[:danger] = "You do not have permission to do this."
				redirect_to(root_url) 
			end
		end

end
