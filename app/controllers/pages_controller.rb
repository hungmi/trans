class PagesController < ApplicationController
  before_action :skip_pundit

  def home
    @show_footer = false
  end

  def about
  end

  def agenda
  end

  def speaker
    @speakers = Person.all.order("people.order DESC NULLS LAST, people.id DESC, people.en_name ASC, people.zh_name ASC")
  end

  def partner
    @partners = Partner.all.order("partners.order DESC NULLS LAST, partners.id DESC")
  end

  def faq
  end

  def review
  end

  def register
    @show_footer = false
  end

  private

  def skip_pundit
    skip_authorization
  end
end