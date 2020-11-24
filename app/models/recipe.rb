class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :measures
  has_many :ingredients, through: :measures
  accepts_nested_attributes_for :measures

  validates :title, :description, presence: true

end
