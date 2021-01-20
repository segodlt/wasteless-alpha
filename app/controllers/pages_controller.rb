class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :dashboard]

  def home
    @categories = Category.all
    @category = Category.find_by(id:params[:category_id])
    @recipes = Recipe.order(created_at: :desc)
    if params[:category_id].present?
      @recipes = @recipes.where(category_id:params[:category_id])
    end

    if params[:query].present?
      sql_query = " \
      recipes.title ILIKE :query \
      OR recipes.description ILIKE :query \
      OR categories.name ILIKE :query \
      OR ingredients.name ILIKE :query \
      "
      @recipes = @recipes.joins({measures: :ingredient}).joins(:category).where(sql_query, query:"%#{params[:query]}%").uniq
      # @recipes.
    end
  end

  # def dashboard
  #   @user = current_user
  # end

  # def account
  #   @user = current_user
  # end
end
