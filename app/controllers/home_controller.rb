class HomeController < ApplicationController
  def index
    @quotes = Quote.includes(:source, :user).take(5)
  end
end
