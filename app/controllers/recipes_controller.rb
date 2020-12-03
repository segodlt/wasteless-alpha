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
    @recipe.measures.build
    authorize @recipe
  end

  def create
    new_params = recipe_params
    new_params[:measures_attributes]

    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    new_measure = Measure.new
    new_measure.recipe = @recipe
    new_measure.save
    authorize @recipe

    if @recipe.save
      redirect_to recipe_create_recipe_sb_path(:addDescription, recipe_id: @recipe.id)
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
    params.require(:recipe).permit(:title, :category_id, :id, measures_attributes: [:id, :quantity, :recipe_id, :unit_id, :optionnal, :ingredient_id])
  end

end
