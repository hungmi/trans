class ApplicationController < ActionController::Base
	include Pundit
	helper_method :current_user, :user_signed_in?
	after_action :verify_authorized
	before_action :set_locale
	 
	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end

	def default_url_options
	  { locale: I18n.locale }
	end
	
	def current_user
	  @current_user ||= User.find_by_id(session[:user_id])
	end

	def user_signed_in?
	  current_user.present?
	end

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	private
	def user_not_authorized
	  flash[:warning] = '請先登入。'
	  redirect_to admin_signin_path(back_path: request.fullpath)
	end
end
