class SearchController < ApplicationController
  def index
    # get search query and selected category from the parameters
    search_query = params[:search_query]
    view_category = params[:view_category]

    # if both query and category is present:
    # Join quote with source and categories, and filter by public? and categories and filter search query with quote and source
    if search_query.present? && view_category.present? 
      @quotematch = Quote.joins(:source, :categories).where("ispublic = true AND (qtext LIKE ? OR (sources.fname || ' ' || sources.lname) LIKE ?) AND categories.id = ?", "%#{search_query}%", "%#{search_query}%", view_category).distinct
    
    # if only category is present:
    # Join quote with categories, and filter by public? and category
    elsif !search_query.present? && view_category.present?
      @quotematch = Quote.joins(:categories).where("ispublic = true AND categories.id = ?", view_category).distinct
    
    # if only query is present:
    # Join quote with source, and filter by public? and filter search query with quote and source
    elsif search_query.present? && !view_category.present?
      @quotematch = Quote.joins(:source).where("ispublic = true AND (qtext LIKE ? OR (sources.fname || ' ' || sources.lname) LIKE ?)", "%#{search_query}%", "%#{search_query}%").distinct
    end
  end
end