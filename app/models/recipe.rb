class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :measures
  has_many :ingredients, through: :measures
end
