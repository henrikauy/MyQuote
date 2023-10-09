class Quote < ApplicationRecord
  belongs_to :user
  belongs_to :source
  has_many :quote_categories, dependent: :destroy
  has_many :categories, through: :quote_categories
end
