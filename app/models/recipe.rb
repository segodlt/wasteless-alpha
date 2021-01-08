class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :measures, dependent: :destroy
  has_many :ingredients, through: :measures
  has_many :units, through: :measures
  accepts_nested_attributes_for :measures

  validates :title, :description, :usage, presence: true, if: :active?
  validates_associated :ingredients, :measures, presence: true, if: :active?

  def active?
    status == 'active'
  end

# if params[:query].present?
#       sql_query = " \
#         recipes.title @@ :query \
#         OR recipes.description @@ :query \
#         OR categories.name @@ :query \
#       "
#       @recipes = Recipe.joins(:category).where(sql_query, query: "%#{params[:query]}%")
#     else
#       @movies = Recipe.all
#   end
end
