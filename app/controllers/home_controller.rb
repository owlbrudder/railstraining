class HomeController < ApplicationController
  def index
  end

  def about
    @about_us = "HutchCoder is an international software services business."
  end

end
