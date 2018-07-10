class Person < ApplicationRecord
	validates :zh_name, :en_name, presence: true
	has_one_attached :cover
end