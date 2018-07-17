class Partner < ApplicationRecord
	has_one_attached :cover
	validates_format_of :link, with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, message: "請確認連結網址是否正確，並包含開頭 http:// 或 https://"
	validates :order, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
	enum category: { organizer: 0, co_organizer: 1, exhibitor: 2, community_partner: 3, media: 4 }
end
