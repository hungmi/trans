class AdminController < ApplicationController
	layout "admin"

	def set_locale
	  I18n.locale = I18n.default_locale
	end
end