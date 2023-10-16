class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]
  before_action :require_login, except: [:index, :show] # Must be logged in unless when looking at quotes and its details

  # GET /quotes or /quotes.json
  def index
    # If user is logged in, get quotes of the user, otherwise get all quotes
    if current_user
      @quotes = current_user.quotes
    else
      @quotes = Quote.all
    end
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)

    respond_to do |format|
      # If quote is successfully created, go to the quote and give success message
      if @quote.save
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      # Otherwise, throw error
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    respond_to do |format|
      # If quote is successfully updated, got to the quote and give success message
      if @quote.update(quote_params)
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully updated." }
        format.json { render :show, status: :ok, location: @quote }
      else
      # Otherwise, throw error
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy

    # Go to /quotes and give success message
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: "Quote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      # require quote details
      # category_ids is an array to allow multiple categories
      # source_attributes permits the nested attributes associated with the quotes form
      params.require(:quote).permit(:qtext, :qyear, :qcom, :ispublic, :user_id, :source_id, category_ids: [], source_attributes: [:fname, :lname, :byear, :dyear, :bio])
    end
end
