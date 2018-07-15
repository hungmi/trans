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
    @speakers = Person.all.order(en_name: :asc, zh_name: :asc)
  end

  def partner
    @partners = Partner.all.order(id: :desc)
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