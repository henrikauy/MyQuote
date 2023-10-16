class SearchController < ApplicationController
  def index
    search_query = params[:search_query]
    view_category = params[:view_category]

    if search_query.present? && view_category.present?
      @quotematch = Quote.joins(:source, :categories).where("ispublic = true AND (qtext LIKE ? OR (sources.fname || ' ' || sources.lname) LIKE ?) AND categories.id = ?", "%#{search_query}%", "%#{search_query}%", view_category).distinct

    elsif !search_query.present? && view_category.present?
      @quotematch = Quote.joins(:categories).where(categories: { id: view_category }).distinct

    elsif search_query.present? && !view_category.present?
      @quotematch = Quote.joins(:source).where("ispublic = true AND (qtext LIKE ? OR (sources.fname || ' ' || sources.lname) LIKE ?)", "%#{search_query}%", "%#{search_query}%").distinct
    end
  end
end