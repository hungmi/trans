class Person < ApplicationRecord
	has_one_attached :cover
	validates :order, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

	def i18n_name
		if en_name.present? && zh_name.present?
			I18n.locale == :en ? en_name : zh_name
		elsif en_name.present?
			en_name
		else
			zh_name
		end
	end

	def i18n_title
		if en_title.present? && zh_title.present?
			I18n.locale == :en ? en_title : zh_title
		elsif en_title.present?
			en_title
		else
			zh_title
		end
	end

	def i18n_description
		if en_description.present? && zh_description.present?
			I18n.locale == :en ? en_description : zh_description
		elsif en_description.present?
			en_description
		else
			zh_description
		end
	end
end