class PagesController < ApplicationController
  def home
    @show_footer = false
  end

  def about
  end

  def agenda
  end

  def speaker
  end

  def partner
  end

  def faq
  end

  def review
  end

  def register
    @show_footer = false
  end
end
