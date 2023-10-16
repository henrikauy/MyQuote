class Quote < ApplicationRecord
  #Database associations
  belongs_to :user
  belongs_to :source
  has_many :quote_categories, dependent: :destroy
  has_many :categories, through: :quote_categories

=begin
  --------------------------------AI GENERATIVE TOOLS USED BELOW----------------------
  OpenAI. (2023). ChatGPT (Version 4) [AI text generation tool]. https://chat.openai.com/
  Prompt:
  <% if @quote.errors.any? %>
  <div class="alert alert-danger">
    <ul>
      <% @quote.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
    </ul>
  </div>
  <% end %>

  <%= form_with(model: @quote, local: true) do |f| %>
    <%= f.hidden_field :user_id, value: current_user.id %>

    <div class="form-group" style="padding-bottom: 10px;">
      <%= f.label :qtext, "Quote", class: "form-label" %>
      <%= f.text_area :qtext, placeholder: 'Enter the quote text', class: 'form-control' %>
    </div>

    <div class="form-group" style="padding-bottom: 10px;">
      <%= f.label :qtext, "Publication year", class: "form-label" %>
      <%= f.text_field :qyear, placeholder: 'Enter the publication year', class: 'form-control' %>
    </div>

    <div class="form-group" style="padding-bottom: 10px;">
      <%= f.label :qtext, "Comment (optional)", class: "form-label" %>
      <%= f.text_area :qcom, placeholder: 'Enter your comment', class: 'form-control' %>
    </div>

    <div class="form-check" style="padding-bottom: 10px;">
      <%= f.label :ispublic, class: "form-check-label" do %>
        Public
        <%= f.check_box :ispublic, class: "form-check-input" %>
      <% end %>
    </div>

    <div class="form-group" style="padding-bottom: 10px;">
      <%= f.label :category_ids, "Categories", class: "form-label" %>
      <% Category.all.each do |category| %>
        <div class="form-check">
          <%= f.check_box :category_ids, { multiple: true, class: 'form-check-input' }, category.id, nil %>
          <%= f.label category.catname, class: 'form-check-label' %>
        </div>
      <% end %>
    </div>

    <div class="form-group" style="padding-bottom: 10px;">
      <%= f.label :source_id, "Source", class: "form-label" %>
      <%= f.collection_select :source_id, Source.all, :id, :full_name, {prompt: 'Select a Source'}, class: 'form-control' %>
    </div>

    <div class="mt-3">
      <%= f.submit 'Save Quote', class: 'btn btn-primary btn-lg' %>
    </div>
  <% end %>

  What should i do when the philosopher that the quote belongs to doesnt exist in my datebase yet? How should i let the user create a new philosopher(source)
=end

  # Allows quotes to accept nested attributes for its associated source, enabling the creation or updating of a source directly via the quote’s attributes.
  accepts_nested_attributes_for :source, allow_destroy: true, reject_if: :all_blank
  #----------------------------------AI GENERATIVE TOOLS END HERE--------------------------------------
  
  # Custom validation to check if the quote text is present.
  validate :check_qtext

  #-------------------------------AI GENERATIVE TOOLS USED BELOW--------------------------------------
  #prompt:
  #validates :categories , presence: {message: "Quote must have be in atleast one category!"}
  #This is not validating properly. Categories has a many to many relationship with the quote

  # Custom validation to check if the quote is associated with at least one category.
  validate :check_category

  private

  # function to check if categories are present.
  def check_category
    if categories.empty?
      errors.add(:base, "Quote must be in atleast one category!") # error message
    end
  end

  #-------------------------------AI GENERATIVE TOOLS END HERE-------------------------------------
  
  # function to check if quote text is present.
  def check_qtext
    if qtext.empty?
      errors.add(:base, "Quote text cannot be blank!") # error message
    end
  end
end
