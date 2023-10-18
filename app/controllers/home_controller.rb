class HomeController < ApplicationController
  def index
    # Retrieve 5 quotes along and their sources, ordered by their creation date in descending order. Must be public
    @quotes = Quote.includes(:source).where(ispublic: true).order(created_at: :desc).take(5)
  end

  # Quotes belonging to current user
  def uquotes
    # Retrieve all quotes owned by the current user 
    @quotes = Quote.where(user_id: session[:user_id])
  end
  
end
