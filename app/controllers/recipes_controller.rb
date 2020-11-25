class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]


  def index
   @recipes = policy_scope(Recipe).where(user_id:current_user)
  end

  def show
    @recipe = Recipe.find(params[:id])
    authorize @recipe
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
      # redirect_to create_recipe_sb_path
      redirect_to recipes_path
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
    params.require(:recipe).permit(:title, :description, :category_id, :usage)
  end

  # , photos: [], measures_attributes: [:id, :quantity, :recipe_id, :unit_id, :optionnal, :ingredient_id]

end
