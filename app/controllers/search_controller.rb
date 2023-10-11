class SearchController < ApplicationController
  def index
    search_query = params[:search_query]
    search_type = params[:search_type]

    if search_query.present?
      if search_type == "quote"
        @quotematch = Quote.where("qtext LIKE ?", "%#{search_query}%").distinct
      elsif search_type == "category"
        @quotematch = Quote.joins(quote_categories: :category).where("categories.catname LIKE ?", "%#{search_query}%").distinct
      elsif search_type == "source"
        @quotematch = Quote.joins(:source).where("sources.fname || ' ' || sources.lname LIKE ?", "%#{search_query}%").distinct
      end
    end
  end
end