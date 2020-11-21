class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
   @recipes = policy_scope(Recipe).where(user_id:current_user)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @favorite = @recipe.favorites.where(user_id:current_user.id).first if user_signed_in?
    authorize @recipe

    # @review = Review.new if user_signed_in?
  end

  def new
    @recipe = Recipe.new
    authorize @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    authorize @recipe
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    authorize @recipe
  end

private

  def recipe_params
    params.require(:recipe).permit(:title, :description, :category_id, photos: [], measures_attributes: [:id, :ingredient_id, :listed, :quantity, :optionnal])
  end
end
