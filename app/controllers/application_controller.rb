class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_filter :set_gon_variables


	def set_gon_variables
		gon.google_analytics_id = Rails.application.secrets[:google_analytics_id]
	end

end
