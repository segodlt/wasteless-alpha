class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :measures
  has_many :ingredients, through: :measures
  accepts_nested_attributes_for :measures

  #validates :title, :description, presence: true
if params[:query].present?
      sql_query = " \
        recipes.title @@ :query \
        OR recipes.description @@ :query \
        OR categories.name @@ :query \
      "
      @recipes = Recipe.joins(:category).where(sql_query, query: "%#{params[:query]}%")
    else
      @movies = Recipe.all
    end
  end
end
