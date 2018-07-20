class AdminController < ApplicationController
	layout "admin"

	def set_locale
	  I18n.locale = :"zh-TW"
	end
end