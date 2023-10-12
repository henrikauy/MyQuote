class HomeController < ApplicationController
  def index
    @quotes = Quote.includes(:source).take(5)
  end

  def uquotes
    @quotes = Quote.includes(:source).where(user_id: session[:user_id])
  end
  
end
