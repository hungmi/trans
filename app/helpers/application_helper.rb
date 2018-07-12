module ApplicationHelper
  def render_chinese_class(str)
    if !!(str =~ /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/)
      'chinese'
    end
  end

	def meta_title
    @page_title.present? ? '#{@page_title} | TRANS' : 'TRANS'
  end

  def not_desktop?
    browser = Browser.new(request.user_agent)
    browser.mobile? || browser.tablet?
  end

  def notice_message(opts = {})
    if flash.any?
      flash.map do |type, message|
        content_tag :div, class: "alert alert-#{type}", role:'alert' do
          content_tag :strong, type.capitalize
          message
        end
      end[0]
    end
  end
end
